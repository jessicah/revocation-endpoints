#!/usr/bin/env sh

psql -h crt.sh -p 5432 -U guest certwatch -c 'select distribution_point_url from public.crl' -o crl.txt
grep crl.txt -o -e '^ http://[^/]*' | sed -e 's;^;0.0.0.0 ;' -e 's; http://;;' | sort | uniq > crl.list

psql -h crt.sh -p 5432 -U guest certwatch -c 'select url from public.ocsp_responder' -o ocsp.txt
grep ocsp.txt -o -e '^ http://[^/]*' | sed -e 's;^;0.0.0.0 ;' -e 's; http://;;' | sort | uniq > ocsp.list
