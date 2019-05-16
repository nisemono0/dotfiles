#!/bin/bash
sensors | grep SYSTIN | awk '{print substr($2, 2)}'

