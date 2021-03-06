# Singularity Client

Command line tool for easy communication with your Singularity server.

## Installation

Add this line to your application's Gemfile:

    gem 'singularity_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install singularity_client

## Configuration

Configuration options may be declared from the command line,
or defined in a `.singularity.yml` file.

By default, the tool will start looking for a `.singularity.yml` in your current working directory,
and will work its way up to the root directory. Specify a file via the `--config` command line option.

### Available configurations:

<table>
  <tr>
    <th>Key</th>
    <th>Description</th>
    <th>Type</th>
    <th>Required</th>
    <th>Example</th>
  </tr>
  <tr>
    <td><tt>singularity_url</tt></td>
    <td>URL for the singularity server</td>
    <td>String</td>
    <td>Yes</td>
    <td><tt>'http://singularity.net'</tt></td>
  </tr>
  <tr>
    <td><tt>singularity_port</tt></td>
    <td>Port the singularity server is operating on</td>
    <td>String</td>
    <td>Yes</td>
    <td><tt>'9000'</tt></td>
  </tr>
  <tr>
    <td><tt>github_organization</tt></td>
    <td>Default github organization to use</td>
    <td>String</td>
    <td>No</td>
    <td><tt>'Behance'</tt></td>
  </tr>
</table>

## Usage

```
Commands:
  singularity add REPO_NAME PROJECT_NAME        # Add a github repository to singularity
  singularity comment REPO_NAME PR_NUM COMMENT  # Write comment to a pull request
  singularity config                            # Get the current singularity config object
  singularity help [COMMAND]                    # Describe available commands or one specific command

Options:
  -c, [--config=CONFIG]                      # Specify path to a .singularity.yml file
      [--singularity-url=SINGULARITY_URL]    # Override the default singularity url
      [--singularity-port=SINGULARITY_PORT]  # Override the default singularity port
  -d, [--debug], [--no-debug]                # Turn on debug mode

```

## Contributing

1. Fork it ( https://github.com/behance/singularity_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
