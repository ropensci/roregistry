RSCRIPT = Rscript --no-init-file

all:
	${RSCRIPT} -e 'library(methods)'

make_urls:
	cat registry.json | jq --raw-output '.packages[] | select(.on_cran == false) | .name' | sort | awk '{print "http://crandb.r-pkg.org/"$$1}'

now_on_cran:
	cat registry.json | jq --raw-output '.packages[] | select(.on_cran == false) | .name' | sort | awk '{print "http://crandb.r-pkg.org/"$$1}' | xargs curl --silent --output /dev/null -w "\n%{http_code}\t%{url_effective}\n" > output.txt

# No real targets!
.PHONY: all make_urls now_on_cran

