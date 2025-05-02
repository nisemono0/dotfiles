#!/bin/bash

case "$1" in
    --run-freeze) transformers_ocr recognize --freeze ;;
    --run) transformers_ocr recognize ;;
    --hold-freeze) transformers_ocr hold --freeze ;;
    --hold) transformers_ocr hold ;;
    *) exit 1 ;;
esac
