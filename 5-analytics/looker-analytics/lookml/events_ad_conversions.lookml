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

- view: events
  sql_table_name: atomic.com_snowplowanalytics_ad_impression
  fields:

# DIMENSIONS # 

  - dimension: event_id
    primary_key: true
    sql: ${TABLE}.root_id

  - dimension: event_type
    sql: ${TABLE}.event_type
    hidden: true

  - dimension: conversion_id
    sql: ${TABLE}.conversion_id

  - dimension: campaign_id
    sql: ${TABLE}.campaign_id

  - dimension: advertiser_id
    sql: ${TABLE}.advertiser_id

  - dimension: category
    sql: ${TABLE}.category

  - dimension: action
    sql: ${TABLE}.action

  - dimension: property
    sql: ${TABLE}.property

  - dimension: cost_model
    sql: ${TABLE}.cost_model

  - dimension: cost
    sql: ${TABLE}.cost

  - dimension: initial_value
    sql: ${TABLE}.initial_value

# MEASURES #

  - measure: conversion_count
    type: count_distinct
    sql: ${event_id} 
    filters:
      event_type: ad_conversion

  - measure: cpa_cost
    type: sum
    decimals: 2
    sql: SUM(CASE WHEN ${cost_model}=='cpa' THEN ${cost} ELSE 0 END)/1000
    
  - measure: cpm_cost
    type: number
    decimals: 2
    sql: SUM(${cost})/1000
    filters:
      cost_model: 'cpm'

  - measure: value_driven_initial_estimate
    type: sum
    sql: ${initial_value}