

// -A one two three 
// -B=four -B=five -B=six 
// -C=seven,eight,nine

params.arr          = ['one', 'two', 'three']  
params.arr_optional = ['one', 'two', 'three']
params.arr_default  = ['one', 'two', 'three']
// params.arr_optional = null
// params.arr_default  = null

process ARRAYS_PARAMS {
    debug true

    input:
      val inarr

    output:
      stdout
    
    script:
      def positional_arr = inarr.join(' ')
      def basic = params.arr.join(' ')
      def basic_delim = params.arr.join(',')
      def basic_nosep = params.arr.join(',')
      def basic_prefixeach = params.arr.collect{ "-A " + it }.join(' ')

      def opt = params.arr_optional ? '-B ' + params.arr_optional.join(' ') : ''
      def opt_delim = params.arr_optional ? '-B ' + params.arr_optional.join(',') : ''
      def opt_nosep = params.arr_optional ? '-B=' + params.arr_optional.join(',') : ''
      def opt_prefixeach = params.arr_optional ? params.arr_optional.collect{ "-B " + it }.join(' ') : ''
      
      def dflt = params.arr_default ? params.arr_default.join(' ') : 'four five six'
      def dflt_delim = params.arr_default ? params.arr_default.join(',') : 'four,five,six'
      def dflt_nosep = params.arr_default ? params.arr_default.join(',') : 'four,five,six'
      def dflt_prefixeach = params.arr_default ? params.arr_default.collect{ "-C " + it }.join(' ') : '-C four -C five -C six'
      
      """
      echo POSITIONAL_ARRAY: ${positional_arr}
      
      echo ''
      echo --- ARRAYS NORMAL ---
      echo BASIC: -A ${basic}
      echo BASIC_DELIM: -A ${basic_delim}
      echo BASIC_NO_SEPARATE: -A=${basic_nosep}
      echo BASIC_PREFIXEACH: ${basic_prefixeach}

      echo ''
      echo --- ARRAYS OPTIONAL ---
      echo OPT: ${opt}
      echo OPT_DELIM: ${opt_delim}
      echo OPT_PREFIXEACH: ${opt_nosep}
      echo OPT_NO_SEPARATE: ${opt_prefixeach}

      echo ''
      echo --- ARRAYS NORMAL ---
      echo DFLT: -C ${dflt}
      echo DFLT_DELIM: -C ${dflt_delim}
      echo DFLT_NO_SEPARATE: -C=${dflt_nosep}
      echo DFLT_PREFIXEACH: ${dflt_prefixeach}
      """
}
      
