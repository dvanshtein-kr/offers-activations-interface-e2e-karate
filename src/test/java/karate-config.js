function fn() {
    var env = karate.env; // get system property 'karate.env'
    if (!env) {
        env = 'test'; // a custom 'intelligent' default
    }
    var config = {
        ngppGMSAppRegUrl: 'https://ngpp-globalmessage-service-'+env+'.ngpp.rch-hdc-axnonprod.kroger.com',
    };
    karate.log('karate.env system property was:', env);
    // don't waste time waiting for a connection or if servers don't respond within 5 seconds
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);
    return config;
}
