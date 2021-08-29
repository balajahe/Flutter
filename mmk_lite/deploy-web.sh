flutter build web
rm ../../balajahe.github.io/flutter/mmk_lite/* -r -f
cp ./build/web/* ../../balajahe.github.io/flutter/mmk_lite/ -r -f
cd ../../balajahe.github.io/flutter/mmk_lite/
git commit -a -m dev
git push
