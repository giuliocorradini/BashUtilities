function parseHTTPRequest {
	query_string=$(head -n1)
	echo "$query_string" | grep -E '(GET|POST) .+ HTTP/1.[01]' &>2
	if [ "$?" == 1 ]; then
		echo -e "HTTP/1.1 400 Bad Request\nContent-Type: text/html\n\nCan't parse this request\nSupport methods: GET, POST"
	else
		local file_path=$(echo "$query_string" | grep -Eo ' .+ ' | tr -d ' ')
		if [ -e "$file_path" ]; then
			echo -e "HTTP/1.1 200 OK\nContent-Type: $(file -b --mime-type $file_path)\n"
			cat "$file_path"
		else
			echo -e "HTTP/1.1 404 Not Found\nContent-Type: text/html\n\nThe requested file either doesn't exist or can't be accessed"
		fi
	fi
	return 0
}

mkfifo request_stream_handler

while true; do
	nc -l 8080 < request_stream_handler | parseHTTPRequest > request_stream_handler
done

rm request_stream_handler
