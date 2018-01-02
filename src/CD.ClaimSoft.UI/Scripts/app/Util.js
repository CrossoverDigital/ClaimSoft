function Util() { }

Util.toJS = function (json) {
    return JSON.parse(JSON.stringify(json));
};