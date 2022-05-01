### SMS Sender (or flooder \^_\^) for **Moldcell** and **Orange** mobile operators.

You can connect via proxy to bypass restriction **«5 sms per 24 hours»** of **Orange** operator.

Best practice is configure **[TOR](https://www.torproject.org/)** to change automatic new IP every one (as example) minute:

Put this three lines to your `torrc` file:
```
CircuitBuildTimeout 10
LearnCircuitBuildTimeout 0
MaxCircuitDirtiness 10
```
Then, restart TOR and use `socks://127.0.0.1:9150` as proxy server

### Dependencies
* Perl, and some perl modules:
    * WWW::Mechanize
    * LWP::Protocol::socks
    * LWP::Protocol::https
* Imagemagick
* Tesseract

### Remember
It's for edicational purposes. Don't be evil! **>:-)**

### Contacts
chinarulezzz, <alexandr.savca89@gmail.com>

