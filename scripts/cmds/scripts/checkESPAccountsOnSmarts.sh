#!/usr/bin/bash

cat > tmp.id_rsa.$$ <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIICWgIBAAKBgQDCSi480e6Y5PXefn3Ft33U4xTkh6f5L3DfNK/+9KWSYD4/OfAB
ZQrlhuaD6vM5C6gypWFzW12fqyXIUjEA4ohjTWwPAijEzfz3ZzjBieLcUWpR6+ww
+b9kc5gADRWHWtviKdrqTKgV2YtWWlvEuMmBDgmOYsqw8leEXOhnPPt+cwIBIwKB
gD0P/+c6qhLLnbr0je2usoS8ZabozmRCHCjkrFdxdd2L9k5iqoQYcSOQzBrU0Bk+
LYxCmvheiyONj4gZ1OMFXhAIIaXy9kZdJOfijFhFulTnqf24Jpj731rcrsyccGW+
RQzcID5voqSvEDvQu/9JitQ857y0AuG0dXg5u/SAld8bAkEA75Rw7rGc0rHogwjN
hVuTvQ6weXHWxvQ562En+l6x8vYIoWifhusB1nk3Nf1OqxojmBdbwZtwtimlY6bI
gg3HqQJBAM+bGbFQSBi+W579CbJNrsqEkW5cofobw5t/Bzg57sStDbTF4TP9ZRve
eBfZviOv0W5Wq6o9Ws9ySSpIrAqFNrsCQA2wtf8C1cLlmEIAgMXKt/wsuaCKKYe2
LzIFjUGBwQaRt1muNQBlM04VjiBXnhhn5Mbcw2omI7KjS0eF35JnL/sCQEct3OxW
ChccsbLaabl5uEVvR84RIZeUfZRmERqXhRA7VSgJVIbaiRDej5MmFU4QZQ/jM4rT
NRPsq170WD4fC3MCQQCrtHgEJxfjMCjyKZ1hZuhr4sXMelUGEc+xF0d2/deMg1Bt
AwEurXQWmnz4onrX/MTB2kH8LTJH/FjWCqMlESnP
-----END RSA PRIVATE KEY-----
EOF

echo "Getting IC Servers...";

for i in `./getAllICServers.pl`; do
	echo -n "$i: ";
	if [[ `/usr/local/bin/ssh -i tmp.id_rsa.$$ -o BatchMode=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l esp $i "hostname" 2>/dev/null` && $? -eq 0 ]]; then
		echo "OK"
	else
		echo "NOT OK";
	fi
done;

rm tmp.id_rsa.$$