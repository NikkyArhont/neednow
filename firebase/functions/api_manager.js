const axios = require("axios").default;
const qs = require("qs");

async function _getCityCall(context, ffVariables) {
  var city = ffVariables["city"];

  var url = `https://maps.googleapis.com/maps/api/place/autocomplete/json`;
  var headers = {};
  var params = {
    input: city,
    types: `geocode`,
    key: `AIzaSyCXo-nn_itHT4mY9-mtKpVbQWMrmGnTaKA`,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _getAdressCall(context, ffVariables) {
  var addres = ffVariables["addres"];

  var url = `https://maps.googleapis.com/maps/api/place/autocomplete/json`;
  var headers = {};
  var params = {
    input: addres,
    types: `geocode`,
    key: `AIzaSyCXo-nn_itHT4mY9-mtKpVbQWMrmGnTaKA`,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _getPlaceLatLngCall(context, ffVariables) {
  var placeId = ffVariables["placeId"];

  var url = `https://maps.googleapis.com/maps/api/place/details/json`;
  var headers = {};
  var params = {
    types: `geometry/location`,
    key: `AIzaSyCXo-nn_itHT4mY9-mtKpVbQWMrmGnTaKA`,
    place_id: placeId,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _bonumAuthCreateCall(context, ffVariables) {
  var tokenHdr = ffVariables["tokenHdr"];

  var url = `https://apis.bonum.mn/bonum-gateway/ecommerce/auth/create`;
  var headers = {
    Authorization: `AppSecret 1fc53f9389f489ff6e04617bd6338a710e1e7c579cb572aec421f560f363119c0e0039e4b765e53c5339c1e6c77279857653f3f3495b81ebcee6bd88f720c51d74c4e293494c57134fa58630be20be71`,
    "X-TERMINAL-ID": `${tokenHdr}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _bonumAuthRefreshCall(context, ffVariables) {
  var tokenType = ffVariables["tokenType"];
  var refreshToken = ffVariables["refreshToken"];

  var url = `https://apis.bonum.mn/bonum-gateway/ecommerce/auth/refresh`;
  var headers = { Authorization: `${tokenType} ${refreshToken}` };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}

/// Helper functions to route to the appropriate API Call.

async function makeApiCall(context, data) {
  var callName = data["callName"] || "";
  var variables = data["variables"] || {};

  const callMap = {
    GetCityCall: _getCityCall,
    GetAdressCall: _getAdressCall,
    GetPlaceLatLngCall: _getPlaceLatLngCall,
    BonumAuthCreateCall: _bonumAuthCreateCall,
    BonumAuthRefreshCall: _bonumAuthRefreshCall,
  };

  if (!(callName in callMap)) {
    return {
      statusCode: 400,
      error: `API Call "${callName}" not defined as private API.`,
    };
  }

  var apiCall = callMap[callName];
  var response = await apiCall(context, variables);
  return response;
}

async function makeApiRequest({
  method,
  url,
  headers,
  params,
  body,
  returnBody,
  isStreamingApi,
}) {
  return axios
    .request({
      method: method,
      url: url,
      headers: headers,
      params: params,
      responseType: isStreamingApi ? "stream" : "json",
      ...(body && { data: body }),
    })
    .then((response) => {
      return {
        statusCode: response.status,
        headers: response.headers,
        ...(returnBody && { body: response.data }),
        isStreamingApi: isStreamingApi,
      };
    })
    .catch(function (error) {
      return {
        statusCode: error.response.status,
        headers: error.response.headers,
        ...(returnBody && { body: error.response.data }),
        error: error.message,
      };
    });
}

const _unauthenticatedResponse = {
  statusCode: 401,
  headers: {},
  error: "API call requires authentication",
};

function createBody({ headers, params, body, bodyType }) {
  switch (bodyType) {
    case "JSON":
      headers["Content-Type"] = "application/json";
      return body;
    case "TEXT":
      headers["Content-Type"] = "text/plain";
      return body;
    case "X_WWW_FORM_URL_ENCODED":
      headers["Content-Type"] = "application/x-www-form-urlencoded";
      return qs.stringify(params);
  }
}
function escapeStringForJson(val) {
  if (typeof val !== "string") {
    return val;
  }
  return val
    .replace(/[\\]/g, "\\\\")
    .replace(/["]/g, '\\"')
    .replace(/[\n]/g, "\\n")
    .replace(/[\t]/g, "\\t");
}

module.exports = { makeApiCall };
