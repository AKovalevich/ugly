namespace Ugly;

use Ugly\IoCInterface;

/**
 * Ugly\IoCInterface
 *
 * Interface for Ugly\IoCInterface
 */
interface IoCInterface extends \ArrayAccess, \Countable, \IteratorAggregate
{

    /**
    * Get data value by key.
    */
    public function get(string! name, default_value);

    /**
     * Removes a service in the container.
     */
    public function remove(string! name);

    /**
    * Set service.
    */
    public function set(string! key, data);

     /**
     * Get all services.
     */
    public function all() -> array;
}