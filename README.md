# PokuponPinger

1. Install bundler
   ```
   gem install bundler
   ```
2. Install bundle

   ```
   bundle install
   ```

3. Configure parameters in ./config/config.yml

   ```
   pinger:
     verbose: true
     delay: 10
     hosts:
       - https://pokupon.ua
       - https://partner.pokupon.ua
     mail:
       smtp:
         hostname: 'smtp.mailtrap.io'
         port: 2525
         username: 'xxx'
         password: 'yyy'
         auth: 'cram_md5'
       credentials:
         from: Pinger Sender <from@smtp.mailtrap.io>
         to: Pinger Receiver <to@smtp.mailtrap.io>
         subject: Servers state!
   ```

4. Run tests

   ```

   bundle exec rake

   ```

5. Run daemon

   ```

   bundle exec ./bin/pokupon_ping

   ```
