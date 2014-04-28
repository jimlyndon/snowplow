# Copyright (c) 2013-2014 Snowplow Analytics Ltd. All rights reserved.
#
# This program is licensed to you under the Apache License Version 2.0,
# and you may not use this file except in compliance with the Apache License Version 2.0.
# You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the Apache License Version 2.0 is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.
#
# Version:     0.1.0
#
# Author(s):   Yali Sassoon
# Copyright:   Copyright (c) 2013-2014 Snowplow Analytics Ltd
# License:     Apache License Version 2.0

- view: ad_impressions
  sql_table_name: atomic.com_snowplowanalytics_ad_impression
  fields:

# DIMENSIONS # 

  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.root_id

  - dimension: event_type
    sql: ${TABLE}.event_type
    hidden: true

  - dimension: impression_id
    sql: ${TABLE}.impression_id

  - dimension: zone_id
    sql: ${TABLE}.zone_id

  - dimension: banner_id
    sql: ${TABLE}.banner_id

  - dimension: campaign_id
    sql: ${TABLE}.campaign_id

  - dimension: advertiser_id
    sql: ${TABLE}.advertiser_id

  - dimension: target_url
    sql: ${TABLE}.target_url

  - dimension: cost_model
    sql: ${TABLE}.cost_model

  - dimension: cost
    sql: ${TABLE}.cost

  # MEASURES #

  - measure: impressions_count
    type: count_distinct
    sql: ${event_id} 
    filters:
      event_type: ad_impression

  - measure: cpa_cost
    type: sum
    decimals: 2
    sql: SUM(CASE WHEN ${cost_model}=='cpm' THEN ${cost} ELSE 0 END)/1000