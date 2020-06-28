#!/bin/bash

pull_id=$(echo ${{ github.ref }} | sed -E 's|refs/pull/||' | sed -E 's|/merge||')
echo "::set-env name=PULL_ID::$pull_id"
echo "::set-env name=PULL_URL::$(echo https://github.com/${{ github.repository }}/pull/$pull_id)"
echo "::set-env name=BRANCH::$(echo ${{ github.head_ref }} | sed -E 's|refs/[a-zA-Z]+/||')"
echo "::set-env name=BUILD_URL::$(echo https://github.com/${{ github.repository }}/actions/runs/${{ github.run_id }})"
