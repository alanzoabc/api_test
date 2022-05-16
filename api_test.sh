#!/bin/bash
#Please export your own api key using the command commented out below.
#export api_key=<your own api key>
api_key=${api_key}
url="https://api.openweathermap.org/data/2.5/weather?q=London&appid=${api_key}"

response=`curl -X GET ${url}`
status_code=$(curl --write-out %{http_code} --silent --output /dev/null ${url})
echo $response

function processResponse {
  if [ $1 -ne "200" ]; then 

    echo "Request failed"
    echo ${response}

  else
    echo "Request successful, response:"
    echo $response | python -m json.tool > results.json
    cat results.json

  fi

}

processResponse $status_code