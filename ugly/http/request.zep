namespace Ugly\Http;

class Request
{
    const METHOD_HEAD = "HEAD";
    const METHOD_GET = "GET";
    const METHOD_POST = "POST";
    const METHOD_PUT = "PUT";
    const METHOD_PATCH = "PATCH";
    const METHOD_DELETE = "DELETE";
    const METHOD_OPTIONS = "OPTIONS";
    const METHOD_OVERRIDE = "_METHOD";

	/**
	 * Gets variable from _SERVER superglobal
	 */
	public function getServer(string! name)
	{
		var serverValue;

		if fetch serverValue, _SERVER[name] {
			return serverValue;
		}
		return null;
	}

	/**
	 * Gets HTTP header from request data
	 */
	public final function getHeader(string! header) -> string
	{
		var value, name;

		let name = strtoupper(strtr(header, "-", "_"));

		if fetch value, _SERVER[name] {
			return value;
		}

		if fetch value, _SERVER["HTTP_" . name] {
			return value;
		}

		return "";
	}

    /**
     * Get HTTP method
     * @return string
     */
    public function getMethod() -> string
    {
        return this->getServer("REQUEST_METHOD");
    }

    /**
     * Is this a GET request?
     * @return bool
     */
    public function isGet() -> boolean
    {
        return this->getMethod() === self::METHOD_GET;
    }

    /**
     * Is this a POST request?
     * @return bool
     */
    public function isPost() -> boolean
    {
        return this->getMethod() === self::METHOD_POST;
    }

    /**
     * Is this a PUT request?
     * @return bool
     */
    public function isPut() -> boolean
    {
        return this->getMethod() === self::METHOD_PUT;
    }

    /**
     * Is this a PATCH request?
     * @return bool
     */
    public function isPatch() -> boolean
    {
        return this->getMethod() === self::METHOD_PATCH;
    }

    /**
     * Is this a DELETE request?
     * @return bool
     */
    public function isDelete() -> boolean
    {
        return this->getMethod() === self::METHOD_DELETE;
    }

    /**
     * Is this a HEAD request?
     * @return bool
     */
    public function isHead() -> boolean
    {
        return this->getMethod() === self::METHOD_HEAD;
    }

    /**
     * Is this a OPTIONS request?
     * @return bool
     */
    public function isOptions() -> boolean
    {
        return this->getMethod() === self::METHOD_OPTIONS;
    }

    /**
     * Is this an AJAX request?
     * @return bool
     */
 	public function isAjax() -> boolean
 	{
 		return isset _SERVER["HTTP_X_REQUESTED_WITH"] && _SERVER["HTTP_X_REQUESTED_WITH"] === "XMLHttpRequest";
 	}

    ///**
    // * Fetch GET and POST data
    // */
    //public function params(key = null, default_value = null)
    //{
    //    var union;
    //    let union = array_merge(this->get(), this->post());
    //    if (key) {
    //       return isset union[key]  ? union[key] : default_value;
    //    }
    //    return union;
    //}

    public function methodGet()
    {
        return self::METHOD_GET;
    }

    public function methodPost()
    {
        return self::METHOD_POST;
    }

    public function methodPut()
    {
        return self::METHOD_PUT;
    }

    public function methodDelete()
    {
        return self::METHOD_DELETE;
    }
}