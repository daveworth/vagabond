# Vagabond

Vagabond is currently a work-in-progress. Features may be missing or subject to change.

## What it is

Vagabond — until the 0.1.0 release — is a playground for a few different
approaches for integration testing of infrastructure. We're still determining
how best to handle a lot of things with the goal of making  Vagabond very
modular so we can re-use parts of it for other, similar projects (think Vagabond
but on EC2 / Rackspace).

When we started on this particular revision of the code we pretty much threw out
the old code because it made some fundamentally wrong assumptions and wouldn't
have worked going forward, so all of this is new.

### Local vs. Remote specs

Vagabond now supports "remote specs".  Remote specs are those specs run from
your local host (as opposed to the guest vagabond spins up) to check external
behaviors of that host.  For example you may want to run some Capybara specs
against a web app hosted on the guest or check for open ports and that Apache
and OpenSSH are running _and_ reachable on the guest.  How cool would that be?
Well it's working!

## What it isn't

Stable (yet).

Finished (yet).

## That Said...

We'd love some of your help or input!

## Developing

1. Install VirtualBox.
2. Install Bundler.
3. Clone repository
4. Update Submodules `git submodule init && git submodule update`
5. Run `bundle install`
6. Run `rake vagabond:spec`

### Adding new resources and matchers for Remote specs

* Any gems you need for remote specs should be tagged with the commented
  `#group: :remote_test` in the `Gemfile` (see the examples for `ruby-nmap` and
  `capybara-webkit`).  _Do Not_ put them in a group with a block as the ugliest
  hack ever in the Chef default cookbook will then fail to do The Right Thing
  during provisioning and this whole house of cards will fail.

* Webapp specs wrap up a Capybara-webkit instance so you can write your standard
  integration tests against an app deployed on your host.  Check that you can
  login (full stack tests!) and do cool things.
