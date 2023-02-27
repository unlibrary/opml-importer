# OPML importer for Unlibrary

This is a simple script to import an OPML file into a Unlibrary account. I use this to import all of my YouTube subscriptions from [a OPML file that I publish to my website](https://geheimesite.nl/videos.opml).

## Usage

```shell
mix run -e 'OPMLImporter.main(OPML_URL, USERNAME, PASSWORD)'
```

- `OPML_URL`: the URL to your OPML file
- `USERNAME`: the username for the account the OPML gets imported into
- `PASSWORD`: the password for the account the OPML gets imported into

> **Warning**
> This importer overwrites all existing sources in the account!

### Example

```shell
$ mix run -e 'OPMLImporter.main("https://geheimesite.nl/videos.opml")'

--2023-02-27 20:41:29--  https://geheimesite.nl/videos.opml
Loaded CA certificate '/etc/ssl/certs/ca-certificates.crt'
Resolving geheimesite.nl (geheimesite.nl)... 94.124.122.11, 2a02:9e0:9000::11
Connecting to geheimesite.nl (geheimesite.nl)|94.124.122.11|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 8985 (8.8K) [text/xml]
Saving to: ‘priv/1677526889772683380.opml’

priv/1677526889772683380.op 100%[===========================================>]   8.77K  --.-KB/s    in 0s

2023-02-27 20:41:30 (95.1 MB/s) - ‘priv/1677526889772683380.opml’ saved [8985/8985]

Added the following sources to the yt account:

* [YT] Vox
* [YT] sandiction
* [YT] Veritasium
* [YT] Tom Scott
* [YT] rekrap2
* [YT] SalC1
* [YT] Frame of Essence
* [YT] Mysticat
* [YT] Mark Rober
* [YT] Sebastian Lague
* [YT] Fireship
* [YT] Vimlark
* [YT] Coldfusion
* [YT] Johnny Harris
* [YT] Huge *if true
* [YT] Grian
* [YT] Mumbo Jumbo
* [YT] ImpulseSV
* [YT] iskall85
* [YT] Tom Scott+
* [YT] Arjan Lubach
* [YT] exurb1a
* [YT] Aperture
* [YT] NOS op 3
* [YT] CGP Grey
* [YT] SHAUN
```
