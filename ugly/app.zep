namespace Ugly;

use Ugly\IoC;

class App
{

    /**
     * @var \Ugly\IoC
     */
    public container;

    public function __construct()
    {
        // Setup IoC container
        let this->container = new IoC();

        this->container->set("router", "Ugly\\Router");
        this->container->set("request", "Ugly\\Http\\Request");
    }

    public function go() {
        var matched, route, output;
        let output = "";

        let matched = this->container->router->getMatchedRoutes(_GET["_url"], this->container->request->getMethod());


        if !empty matched {
            for route in matched {
                let output = output . this->container->router->dispatch(route);
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
        this->container->router->setRoute(pattern, callback, this->container->request->methodGet());
    }

    /**
     * Add POST route
     */
    public function post(string! pattern, string! callback)
    {
        this->container->router->setRoute(pattern, callback, this->container->request->methodPost());
    }

    /**
     * Add PUT route
     */
    public function put(string! pattern, string! callback)
    {
        this->container->router->setRoute(pattern, callback, this->container->request->methodPut());
    }

    /**
     * Add DELETE route
     */
    public function delete(string! pattern, string! callback)
    {
        this->container->router->setRoute(pattern, callback, this->container->request->methodDelete());
    }
}