#/bin/bash
function handle()
{
start=$(date +%s)
start_ms=${start:0:16}

#awk '{a[$1]++} END{print length(a)}' breakfast_all receptions_all cheap_all
./build_android_2.sh
end=$(date +%s)
end_ms=${end:0:16}
echo "cost time is:"
echo "scale=6;($end_ms -    $start_ms)" | bc
}
 
handle