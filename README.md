# Terraframe #
Terraframe is a processor for a domain-specific language that outputs to the Terraform specification format.

[Terraform][1] is a cool infrastructure-as-code system with a boatload of functionality and a really awesome core that makes building out entire clouds on AWS super easy and super fun. I am a fan.

_But_. But but but. It's not perfect. And personally, ever since HashiCorp went away from Ruby DSLs as configuration, I have been sad. And worse than sad, I have been unproductive as all hell. I'm just not satisfied with the state of the Terraform description language. It's hard to write, its built-in assumptions are gross (the handling of variables is a minor crime in progress), and it's just a huge step back from being able to deploy, say, a Vagrant instance--or, as I have done, [a configurable number of Vagrant instances][2]--in a nice, comprehensible manner.

The configuration, while not CloudFormation-bad, is pretty bad, and I came close to ditching Terraform because it was really hard to write. I got halfway through some ERB templating monstrosity before I learned of a better way: Terraform supports JSON as a declaration notation, and that makes it really easy to build an external DSL that can be exported for use in Terraform.

And that's what Terraframe is. Terraframe makes Terraform pleasant.

## Installation ##

Terraframe is distributed as a RubyGem.

```bash
gem install terraframe
```

## Usage

1. You'll need to have [Terraform][1] installed to actually use the output of Terraframe.
2. Check `terraframe --help` for exhaustive usage details.

## Contributing

1. Fork it ( https://github.com/eropple/terraframe/fork )
2. Create your feature branch under the `feature/` prefix, as with [git-flow][3] (`git flow feature start my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`). Please don't change the version number and please make README changes in a separate commit to make everything comprehensible for me.
5. Make a pull request!

## Thanks ##
- William Lee, my platform engineering co-conspirator at [Leaf][4].
- HashiCorp, 'cause Terraform is fundamentally an awesome project and we're all better because you guys made this.

[1]: https://www.terraform.io
[2]: https://github.com/eropple/mesos-experiments
[3]: https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
[4]: http://engineering.leaf.me