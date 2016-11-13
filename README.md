# Journal

This is a small Rails 5 app for creating a Journal. I built this as a quick
alternative to Day One.

![](https://files.deanpcmad.com/2016/pNpaoI0o1p.png)

## Usage

Run the setup script, edit the `.env` file as required and then run the server

```bash
bin/setup
bin/rails server
```

Then access the app at [localhost:3000](http://localhost:3000)

## Importing data from Day One

Create an export of your Day One journal. You can do this by right clicking the
journal, choosing export and then JSON

![](https://files.deanpcmad.com/2016/w6eWBUmNLV.png)

Extract the zip file into a directory called `dayone` in the root of this app.

Run the `import.rb` script:

```
rails runner import.rb
```

You should see some output like so:

![](https://files.deanpcmad.com/2016/Xw3GZE573T.png)

## Contributing

- Fork this app
- Make some changes
- Create a pull request
- :smile:
