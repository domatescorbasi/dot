#!/bin/bash
find . -xdev -type f -print0 | xargs -0 md5sum | sort | perl -ne 'chomp; $ph=$h; ($h,$f)=split(/\s+/,$_,2); if ($h ne $ph) { $k = $f; } else { unlink($f); link($k, $f); }'