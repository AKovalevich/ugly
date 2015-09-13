namespace Ugly;

class Router
{
    protected routes = [];
    protected matchedRoutes = [];
    protected di;
    protected paramNames = [];

    public function __construct(<IoC> di = null)
    {
        if di !== null {
            let this->di = di;
        }
    }

    public function setRoute(string! pattern, var callback, string! method)
    {
        let this->routes[method][pattern]["pattern"] = pattern;
        let this->routes[method][pattern]["callback"] = callback;
    }

    public function getMatchedRoutes(string! resourceUri, string! requestMethod)
    {
        var route, args;
        let resourceUri = resourceUri->trimleft("/");

        if isset this->routes[requestMethod] {
            for route in this->routes[requestMethod] {
                // First chunk of path should be static and should have length at least three symbols.
                if substr(resourceUri, 0, 3) == substr(route["pattern"], 0, 3) {
                    let args = this->matches(resourceUri, route, requestMethod);
                    unset(this->paramNames);

                    if !empty args {
                        let route["args"] = args;
                        let this->matchedRoutes[] = route;
                    }
                }
            }
        }

        return this->matchedRoutes;
    }

    public function matches(string! resourceUri, var route, string! method)
    {
        var patternAsRegex, paramValues, pattern, name;
        string regex;
        array routeArgs = [];

        let pattern = route["pattern"];
        let patternAsRegex = null;
        let patternAsRegex = preg_replace_callback("#:([\w]+)\+?#", [this, "matchCallback"], str_replace(")", ")?", pattern));

        if (substr(resourceUri, -1) === "/") {
            let patternAsRegex .= "?";
        }
        let regex = "#^" . patternAsRegex . "$#";
        let regex = regex . "i";

        if !preg_match(regex, resourceUri, paramValues) {
            return FALSE;
        }

        for name in this->paramNames {
            if isset paramValues[name] {
                if isset this->paramNames[name] {
                    let routeArgs[name] = explode('/', urldecode(paramValues[name]));
                } else {
                    let routeArgs[name] = urldecode(paramValues[name]);
                }
            }
        }

        return routeArgs;
    }

    public function dispatch(route)
    {
        array matches = [];

        if is_string(route["callback"]) && preg_match("!^([^\:]+)\:([a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)!", route["callback"], matches) {
            var callback_class, callback_method;
            let callback_class = matches[1];
            let callback_method = matches[2];

            if isset route["args"] {
                return call_user_func_array([callback_class, callback_method], route["args"]);
            } else {
                return call_user_func([callback_class, callback_method]);
            }
        } else {
            return call_user_func_array(route["callback"], array_values(route["args"]));
        }
    }

    public function matchCallback(matches)
    {
        // @todo check conditions?
        let this->paramNames[] = matches[1];
        if (substr(matches[0], -1) === "+") {
            let this->paramNames["argsNames"][matches[1]] = true;

            return "(?P<" . matches[1] . ">.+)";
        }

        return "(?P<" . matches[1] . ">[^/]+)";
    }
}