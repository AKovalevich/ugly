namespace Ugly;

use Ugly\IoC;

class App
{
    public $container;

	/**
	 * Ugly\App constructor
	 */
    public function __construct()
    {
        // Setup IoC container
        let this->container = new IoC();
    }
}