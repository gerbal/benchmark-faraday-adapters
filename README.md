# Faraday adapters benchmarking

A simple benchmarking to compare the performance of different Faraday HTTP adapters.

Starts a thin webserver with a HelloWorld endpoint to which the benchmark performs GET requests.

### Usage

From the project's root folder, run:

`ruby server.rb & ruby benchmark.rb`


### Example results

```tsv
                           user     system      total        real
patron                 0.040436   0.029721   0.070157 (  0.129381)
net_http_persistent    0.082035   0.036030   0.118065 (  0.141394)
net_http               0.099019   0.020407   0.119426 (  0.144185)
em_synchrony           0.091491   0.042713   0.134204 (  0.165983)
httpclient             0.087332   0.072761   0.160093 (  0.168402)
em_http                0.102681   0.034315   0.136996 (  0.170986)
typhoeus               0.132477   0.014855   0.147332 (  0.181622)
httpx                  0.194476   0.013141   0.207617 (  0.229202)
excon                  0.199055   0.013400   0.212455 (  0.240389)
http                   0.175902   0.036417   0.212319 (  0.241920)
```