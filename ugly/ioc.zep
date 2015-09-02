namespace Ugly;

use Ugly\IoC;
use Ugly\IoCInterface;

/**
 * Ugly\IoCInterface
 */
class IoC implements IoCInterface
{

    /**
     * Key-value array of arbitrary data
     */
    protected _data = [];

    /**
     * Get data value by key
     */
    public function get(string! name, var parameters = null, var default_value = null)
    {
        var prepareName;
        let prepareName = this->prepareName(name);

        if (this->has(name)) {
            if typeof this->_data[prepareName] == "string" {
                if parameters {
                    let this->_data[prepareName] = create_instance(this->_data[prepareName]);
                } else {
                    let this->_data[prepareName] = create_instance_params(this->_data[prepareName], parameters);
                }

                return this->_data[prepareName];
            }

            if typeof this->_data[prepareName] == "object" {
                return this->_data[prepareName];
            }
        }

        return default_value;
    }

    /**
     * Assign values to the IoC
     */
    public function set(string! name, var data)
    {
        let this->_data[this->prepareName(name)] = data;
    }

    /**
     * Removes a service in the container
     */
    public function remove(string! name) -> boolean
    {
        if (this->has(name)) {
            unset(this->_data[this->prepareName(name)]);
        }

        return true;
    }

    /**
     * Get all services.
     */
    public function all() -> array
    {
        return this->_data;
    }

    /**
     * Check whether a service is defined in the IoC
     */
    public function has(string! name) -> boolean
    {
        return isset this->_data[this->prepareName(name)];
    }

    /**
     * Prepare service name
     */
    public function prepareName(string! name) -> string
    {
        return name->lower();
    }

    /**
     * Magic getter to obtain values from the IoC
     *
     *<code>
     * echo $man->ugly;
     *</code>
     *
     * @param string name
     * @param mixed default value
     * @return mixed
     */
    public function __get(string! name, var default_value = null)
    {
        return this->get(name, default_value);
    }

    /**
     * Magic setter to assign values to the IoC
     *
     *<code>
     * $user->man = "Ugly";
     *</code>
     *
     * @param string name
     * @param object data
     */
    public function __set(string! name, var data)
    {
        return this->set(name, data);
    }

    /**
     * Magic isset to check whether a service is defined in the IoC
     *
     *<code>
     * var_dump(isset($user['ugly']));
     *</code>
     */
    public function __isset(string! name)
    {
        return this->has(name);
    }

    /**
     * Magic unset to remove items using the array syntax
     *
     *<code>
     * unset($user['name']);
     *</code>
     */
    public function __unset(string! name)
    {
        this->remove(name);
    }

    /**
     * Returns the IoC iterator
     *
     * @return \ArrayIterator
     */
    public final function getIterator() -> <ArrayIterator>
    {
    	return new \ArrayIterator(this->_data);
    }

    /**
     * @param string property
     * @param mixed value
     */
    public final function offsetSet(string! name, var value)
    {
        return this->set(name, value);
    }

    /**
     * @param string property
     */
    public final function offsetExists(string! name)
    {
        return this->has(name);
    }

    /**
     * @param string property
     */
    public final function offsetUnset(string! name)
    {
        return this->remove(name);
    }

    /**
     * @param string property
     */
    public final function offsetGet(string! name)
    {
        return this->get(name);
    }

    /**
     * Returns the count of service set in array
     */
    public function count() -> int
    {
        return count(this->_data);
    }
}
