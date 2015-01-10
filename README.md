# Terraframe #
Terraframe is a processor for a domain-specific language that outputs to the Terraform specification format.

[Terraform][1] is a cool infrastructure-as-code system with a boatload of functionality and a really awesome core that makes building out entire clouds on AWS super easy and super fun. I am a fan.

_But_. But but but. It's not perfect. And personally, ever since HashiCorp went away from Ruby DSLs as configuration, I have been sad. And worse than sad, I have been unproductive as all hell. I'm just not satisfied with the state of the Terraform description language. It's hard to write, its built-in assumptions are gross (the handling of variables is a minor crime in progress), and it's just a huge step back from being able to deploy, say, a Vagrant instance--or, as I have done, [a configurable number of Vagrant instances][2]--in a nice, comprehensible manner.

The configuration, while not CloudFormation-bad, is pretty bad, and I came close to ditching Terraform because it was really hard to write. I got halfway through some ERB templating monstrosity before I learned of a better way: Terraform supports JSON as a declaration notation, and that makes it really easy to build an external DSL that can be exported for use in Terraform.

## Installation ##
Terraframe is distributed as a RubyGem.

```bash
gem install terraframe
```

## Usage ##
1. You'll need to have [Terraform][1] installed to actually use the output of Terraframe.
2. Check `terraframe --help` for exhaustive usage details.

## Syntax ##
For the most part, the Terraframe syntax directly parallels the Terraform syntax, but has been Rubified. At present, most of this is a wrapper around `method_missing`, and so it's a _little_ rocky when dealing with nested data types.

You can easily wire up outputs via `id_of(resource_type, resource_name)` and `output_of(resource_type, resource_name, output_name)`, to make things a little less crazy.

Variables can be passed in via the `-v` flag in as many YAML files (which will be deep-merged) as you would like. They are exposed to scripts via the `vars` hash.

Examples: TBD. To get you started, here's the supported invocations:

- `provider :provider_type {}`
- `resource :resource_type, "resource_name" {}`
- `resource_type "resource_name {}`

The latter deserves special attention, because any attempted invocation other than `provider`, `variable`, `resource`, or `provisioner` will be interpreted as a resource. (`resource :resource_type, "resource_name"` is supported for people who like the Terraform syntax.)

## Future Work ##
Right now, Terraframe is being extended as I need it. Pull requests very gratefully accepted for

- Supporting `variable` and `provisioner` blocks, neither are hard but they have to get done.
- Script linting (checking for id existence, only allowing valid keys, etc.) before starting up Terraform. Very low priority, as that's what Terraform itself does.
- Test coverage.

## Contributing ##
1. Fork it ( https://github.com/eropple/terraframe/fork )
2. Create your feature branch under the `feature/` prefix, as with [git-flow][3] (`git flow feature start my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`). Please don't change the version number and please make README changes in a separate commit to make everything comprehensible for me.
5. Make a pull request!

## Thanks ##
- My employer, [Leaf][4], for encouraging the development and use of Terraframe. ([We're hiring!][5])
- William Lee, my platform engineering co-conspirator at Leaf.
- HashiCorp, 'cause Terraform is fundamentally an awesome project and we're all better because you guys made this.

[1]: https://www.terraform.io
[2]: http://edcanhack.com/2014/07/a-virtual-mesos-cluster-with-vagrant-and-chef/
[3]: https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
[4]: http://engineering.leaf.me
[5]: mailto:eropple+hiring@leaf.me