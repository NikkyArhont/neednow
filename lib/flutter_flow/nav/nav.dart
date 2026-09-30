import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? MainWidget() : StartpageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? MainWidget() : StartpageWidget(),
        ),
        FFRoute(
          name: StartpageWidget.routeName,
          path: StartpageWidget.routePath,
          builder: (context, params) => StartpageWidget(),
        ),
        FFRoute(
          name: OnboardingWidget.routeName,
          path: OnboardingWidget.routePath,
          builder: (context, params) => OnboardingWidget(),
        ),
        FFRoute(
          name: EnterPhoneWidget.routeName,
          path: EnterPhoneWidget.routePath,
          builder: (context, params) => EnterPhoneWidget(),
        ),
        FFRoute(
          name: SmsverificationWidget.routeName,
          path: SmsverificationWidget.routePath,
          builder: (context, params) => SmsverificationWidget(
            phone: params.getParam(
              'phone',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EnterEditProfileWidget.routeName,
          path: EnterEditProfileWidget.routePath,
          builder: (context, params) => EnterEditProfileWidget(
            name: params.getParam(
              'name',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: MainWidget.routeName,
          path: MainWidget.routePath,
          builder: (context, params) => MainWidget(),
        ),
        FFRoute(
          name: MyJobsWidget.routeName,
          path: MyJobsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MyJobsWidget(),
        ),
        FFRoute(
          name: JobsWidget.routeName,
          path: JobsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => JobsWidget(),
        ),
        FFRoute(
          name: MyNotificationWidget.routeName,
          path: MyNotificationWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MyNotificationWidget(),
        ),
        FFRoute(
          name: MapFilterWidget.routeName,
          path: MapFilterWidget.routePath,
          builder: (context, params) => MapFilterWidget(),
        ),
        FFRoute(
          name: SearchResultWidget.routeName,
          path: SearchResultWidget.routePath,
          builder: (context, params) => SearchResultWidget(),
        ),
        FFRoute(
          name: AllFilterWidget.routeName,
          path: AllFilterWidget.routePath,
          builder: (context, params) => AllFilterWidget(),
        ),
        FFRoute(
          name: GetOrderWidget.routeName,
          path: GetOrderWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'orderRef': getDoc(['orders'], OrdersRecord.fromSnapshot),
            'byOffer': getDoc(['work'], WorkRecord.fromSnapshot),
          },
          builder: (context, params) => GetOrderWidget(
            orderRef: params.getParam(
              'orderRef',
              ParamType.Document,
            ),
            byOffer: params.getParam(
              'byOffer',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: CreateServiceStartWidget.routeName,
          path: CreateServiceStartWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateServiceStartWidget(),
        ),
        FFRoute(
          name: CreateServiceWidget.routeName,
          path: CreateServiceWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateServiceWidget(),
        ),
        FFRoute(
          name: WorkerKYCWidget.routeName,
          path: WorkerKYCWidget.routePath,
          requireAuth: true,
          builder: (context, params) => WorkerKYCWidget(),
        ),
        FFRoute(
          name: WorkerKYCeditWidget.routeName,
          path: WorkerKYCeditWidget.routePath,
          requireAuth: true,
          builder: (context, params) => WorkerKYCeditWidget(),
        ),
        FFRoute(
          name: ReviewsWidget.routeName,
          path: ReviewsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ReviewsWidget(
            whosReveiws: params.getParam(
              'whosReveiws',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['user'],
            ),
          ),
        ),
        FFRoute(
          name: MyProfileWidget.routeName,
          path: MyProfileWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MyProfileWidget(),
        ),
        FFRoute(
          name: EditProfileWidget.routeName,
          path: EditProfileWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EditProfileWidget(),
        ),
        FFRoute(
          name: MyBalanceWidget.routeName,
          path: MyBalanceWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MyBalanceWidget(),
        ),
        FFRoute(
          name: IncomeWidget.routeName,
          path: IncomeWidget.routePath,
          requireAuth: true,
          builder: (context, params) => IncomeWidget(),
        ),
        FFRoute(
          name: OutcomeWidget.routeName,
          path: OutcomeWidget.routePath,
          requireAuth: true,
          builder: (context, params) => OutcomeWidget(),
        ),
        FFRoute(
          name: ChatListWidget.routeName,
          path: ChatListWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChatListWidget(),
        ),
        FFRoute(
          name: ChatWindowWidget.routeName,
          path: ChatWindowWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'chatDoc': getDoc(['chats'], ChatsRecord.fromSnapshot),
          },
          builder: (context, params) => ChatWindowWidget(
            chatDoc: params.getParam(
              'chatDoc',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: AdminPageLoginWidget.routeName,
          path: AdminPageLoginWidget.routePath,
          builder: (context, params) => AdminPageLoginWidget(),
        ),
        FFRoute(
          name: ServiceDetailsWidget.routeName,
          path: ServiceDetailsWidget.routePath,
          asyncParams: {
            'serviceDoc': getDoc(['services'], ServicesRecord.fromSnapshot),
          },
          builder: (context, params) => ServiceDetailsWidget(
            serviceDoc: params.getParam(
              'serviceDoc',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: WorkPageWidget.routeName,
          path: WorkPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => WorkPageWidget(
            workRef: params.getParam(
              'workRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['work'],
            ),
          ),
        ),
        FFRoute(
          name: EnterLocationCityWidget.routeName,
          path: EnterLocationCityWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EnterLocationCityWidget(
            oldCity: params.getParam(
              'oldCity',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: MyWorkHistoryWidget.routeName,
          path: MyWorkHistoryWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MyWorkHistoryWidget(),
        ),
        FFRoute(
          name: TakeReviewWidget.routeName,
          path: TakeReviewWidget.routePath,
          requireAuth: true,
          builder: (context, params) => TakeReviewWidget(
            reviewReciver: params.getParam(
              'reviewReciver',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['user'],
            ),
            workReview: params.getParam(
              'workReview',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['work'],
            ),
          ),
        ),
        FFRoute(
          name: EnterLocationAdressWidget.routeName,
          path: EnterLocationAdressWidget.routePath,
          builder: (context, params) => EnterLocationAdressWidget(
            oldAddress: params.getParam(
              'oldAddress',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EditServiceWidget.routeName,
          path: EditServiceWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'serviceDocEDit': getDoc(['services'], ServicesRecord.fromSnapshot),
          },
          builder: (context, params) => EditServiceWidget(
            serviceDocEDit: params.getParam(
              'serviceDocEDit',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: ApprovedWorkerWidget.routeName,
          path: ApprovedWorkerWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'workDoc': getDoc(['work'], WorkRecord.fromSnapshot),
          },
          builder: (context, params) => ApprovedWorkerWidget(
            workDoc: params.getParam(
              'workDoc',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: OrderDetailsWidget.routeName,
          path: OrderDetailsWidget.routePath,
          asyncParams: {
            'orderDoc': getDoc(['orders'], OrdersRecord.fromSnapshot),
          },
          builder: (context, params) => OrderDetailsWidget(
            orderDoc: params.getParam(
              'orderDoc',
              ParamType.Document,
            ),
            offerdWork: params.getParam(
              'offerdWork',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: EditOrderWidget.routeName,
          path: EditOrderWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'orderDocEDit': getDoc(['orders'], OrdersRecord.fromSnapshot),
          },
          builder: (context, params) => EditOrderWidget(
            orderDocEDit: params.getParam(
              'orderDocEDit',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: CreateOrderWidget.routeName,
          path: CreateOrderWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateOrderWidget(),
        ),
        FFRoute(
          name: OfferOrderWidget.routeName,
          path: OfferOrderWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'passOrder': getDoc(['orders'], OrdersRecord.fromSnapshot),
          },
          builder: (context, params) => OfferOrderWidget(
            passOrder: params.getParam(
              'passOrder',
              ParamType.Document,
            ),
            preferWorker: params.getParam(
              'preferWorker',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['user'],
            ),
            preferService: params.getParam(
              'preferService',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['services'],
            ),
          ),
        ),
        FFRoute(
          name: ChooseOrderToOffWidget.routeName,
          path: ChooseOrderToOffWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChooseOrderToOffWidget(
            prefworker: params.getParam(
              'prefworker',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['user'],
            ),
            prefServ: params.getParam(
              'prefServ',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['services'],
            ),
          ),
        ),
        FFRoute(
          name: ReviewWithJobsWidget.routeName,
          path: ReviewWithJobsWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'whosReview': getDoc(['user'], UserRecord.fromSnapshot),
          },
          builder: (context, params) => ReviewWithJobsWidget(
            whosReview: params.getParam(
              'whosReview',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: DeniedWorkerWidget.routeName,
          path: DeniedWorkerWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'workDoc': getDoc(['work'], WorkRecord.fromSnapshot),
          },
          builder: (context, params) => DeniedWorkerWidget(
            workDoc: params.getParam(
              'workDoc',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: EnterLocationCityStartWidget.routeName,
          path: EnterLocationCityStartWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EnterLocationCityStartWidget(
            oldCity: params.getParam(
              'oldCity',
              ParamType.String,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AdminMainProfileWidget.routeName,
          path: AdminMainProfileWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminMainProfileWidget(),
        ),
        FFRoute(
          name: AdminPageRegistrationWidget.routeName,
          path: AdminPageRegistrationWidget.routePath,
          builder: (context, params) => AdminPageRegistrationWidget(),
        ),
        FFRoute(
          name: AdminEmploeeWidget.routeName,
          path: AdminEmploeeWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminEmploeeWidget(),
        ),
        FFRoute(
          name: AdminCategoryWidget.routeName,
          path: AdminCategoryWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminCategoryWidget(),
        ),
        FFRoute(
          name: AdminUsersWidget.routeName,
          path: AdminUsersWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminUsersWidget(),
        ),
        FFRoute(
          name: AdminUserCardWidget.routeName,
          path: AdminUserCardWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'userCard': getDoc(['user'], UserRecord.fromSnapshot),
          },
          builder: (context, params) => AdminUserCardWidget(
            userCard: params.getParam(
              'userCard',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: AdminChatsWidget.routeName,
          path: AdminChatsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminChatsWidget(),
        ),
        FFRoute(
          name: AdminWorkCardWidget.routeName,
          path: AdminWorkCardWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'workCard': getDoc(['work'], WorkRecord.fromSnapshot),
          },
          builder: (context, params) => AdminWorkCardWidget(
            workCard: params.getParam(
              'workCard',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: CreateDebateWidget.routeName,
          path: CreateDebateWidget.routePath,
          requireAuth: true,
          asyncParams: {
            'workDoc': getDoc(['work'], WorkRecord.fromSnapshot),
          },
          builder: (context, params) => CreateDebateWidget(
            workDoc: params.getParam(
              'workDoc',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: WebChooseRoleWidget.routeName,
          path: WebChooseRoleWidget.routePath,
          builder: (context, params) => WebChooseRoleWidget(),
        ),
        FFRoute(
          name: WebOrderDetailsWidget.routeName,
          path: WebOrderDetailsWidget.routePath,
          asyncParams: {
            'orderDoc': getDoc(['orders'], OrdersRecord.fromSnapshot),
          },
          builder: (context, params) => WebOrderDetailsWidget(
            orderDoc: params.getParam(
              'orderDoc',
              ParamType.Document,
            ),
            offerdWork: params.getParam(
              'offerdWork',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: WebServiceDetailsWidget.routeName,
          path: WebServiceDetailsWidget.routePath,
          asyncParams: {
            'serviceDoc': getDoc(['services'], ServicesRecord.fromSnapshot),
          },
          builder: (context, params) => WebServiceDetailsWidget(
            serviceDoc: params.getParam(
              'serviceDoc',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: WebChatsWidget.routeName,
          path: WebChatsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => WebChatsWidget(
            choosenChat: params.getParam(
              'choosenChat',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['chats'],
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/startpage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: FlutterFlowTheme.of(context).primary,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Asset_2@4x-8.png',
                      width: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
