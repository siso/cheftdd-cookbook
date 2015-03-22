# cheftdd-cookbook

Cookbook to demo "TDD with Chef" at [March '15 Chef Meetup](http://www.meetup.com/Chef-Sydney/events/220775547/) in Sydney.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['cheftdd']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### cheftdd::default

Include `cheftdd` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[cheftdd::default]"
  ]
}
```

## License and Authors

Author:: Simone Soldateschi (<simone.soldateschi@gmail.com>)
