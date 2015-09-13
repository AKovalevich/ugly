namespace Ugly;

use Ugly\IoC;

class App
{

    /**
     * @var \Ugly\IoC
     */
    public container;
    protected router;
    protected request;

    public function __construct()
    {
        // Setup IoC container
        let this->container = new IoC();

        this->container->set("router", "Ugly\\Router");
        this->container->set("request", "Ugly\\Http\\Request");

        let this->request = this->container->get("request");
        let this->router = this->container->get("router");
    }

    public function go() {
        var matched, route, output;
        let output = "";

        let matched = this->router->getMatchedRoutes(_GET["_url"], this->request->getMethod());

        if !empty matched {
            for route in matched {
                let output = output . this->router->dispatch(route);
            }
        } else {
            let output = this->notFound();
        }

        echo output;
    }

    public function notFound()
    {
        return "Not-Found";
    }

    /**
     * Add GET route
     */
    public function get(string! pattern, var callback)
    {
        this->router->setRoute(pattern, callback, this->request->methodGet());
    }

    /**
     * Add POST route
     */
    public function post(string! pattern, string! callback)
    {
        this->router->setRoute(pattern, callback, this->request->methodPost());
    }

    /**
     * Add PUT route
     */
    public function put(string! pattern, string! callback)
    {
        this->router->setRoute(pattern, callback, this->request->methodPut());
    }

    /**
     * Add DELETE route
     */
    public function delete(string! pattern, string! callback)
    {
        this->router->setRoute(pattern, callback, this->request->methodDelete());
    }
}