#!/bin/bash

sudo chef-solo -c config/solo.rb -j config/attributs.json
