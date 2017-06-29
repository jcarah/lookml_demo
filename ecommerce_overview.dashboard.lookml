- dashboard: ecommerce_overview
  title: Event Activity
  layout: grid
  load_configuration: wait
  refresh_interval: 4 hours

  elements:
  - name: revenue
    title: Revenue
    model: jesse_ecommerce
    explore: users
    type: single_value
    fields: [order_items.total_sales]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true

  - name: number_of_orders
    title: Number of orders
    model: jesse_ecommerce
    explore: users
    type: single_value
    fields: [orders.count]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true

  - name: new_users
    title: New Users
    model: jesse_ecommerce
    explore: users
    type: single_value
    fields: [users.count]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true

  - name: 1st_time_vs_repeat_orders
    title: 1st Time vs. Repeat orders
    model: jesse_ecommerce
    explore: users
    type: looker_column
    fields: [order_facts.first_time_or_repeat_buyer, order_items.total_sales, orders.created_date]
    pivots: [order_facts.first_time_or_repeat_buyer]
    fill_fields: [orders.created_date]
    filters:
      orders.created_date: 30 days
    sorts: [order_facts.first_time_or_repeat_buyer 0, orders.created_date]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
  - name: avg_ltr_age
    title: Average lifetime revenue by age tier
    model: jesse_ecommerce
    explore: users
    type: looker_area
    fields: [user_facts.avg_ltr, users.age_tier, users.created_day_of_month]
    pivots: [users.age_tier]
    fill_fields: [users.age_tier, users.created_day_of_month]
    sorts: [user_facts.avg_ltr desc 0, users.age_tier]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    hidden_series: []

  - name: users_by_gender
    title: New users by gender
    model: jesse_ecommerce
    explore: users
    type: looker_scatter
    fields: [users.gender, user_facts.signup_date_month, users.count]
    pivots: [users.gender]
    fill_fields: [user_facts.signup_date_month]
    sorts: [user_facts.signup_date_month desc, users.gender]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    hidden_series: []

  rows:
  - elements: [revenue, number_of_orders, new_users]
    height: 200
  - elements: [1st_time_vs_repeat_orders]
    height: 500
  - elements: [users_by_gender, avg_ltr_age]
    height: 500
  filters:
  - name: Date
    title: Date
    type: date_filter
    default_value: 30 days
    model: jesse_ecommerce
    explore: users
    field:
    listens_to_filters: []
    allow_multiple_values: true
  # - name: Country
  #   title: Country
  #   type: field_filter
  #   default_value: USA
  #   model: jesse_events
  #   explore: events
  #   field: events.country
  #   listens_to_filters: []
  #   allow_multiple_values: true
