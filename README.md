Prototype pour l'OAQ
====================

Installing and running
----------------------

    $ cd proto-oaq
    $ npm install

    $ cd scripts
    $ coffee creer-collection.coffee
    $ coffee creer-collection-messages.coffee
    $ coffee creer-intervenants.coffee
    $ coffee creer-messages.coffee
    $ cd ..

    $ export NUXEO_RLNX_CREDS=user:password
    $ ./node_modules/.bin/node_dev app.js
