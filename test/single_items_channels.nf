

process SINGLE_ITEMS_CHANNELS {
    input:
      path pos
      val opt
      val opt_optional
      val opt_default
      val flag_true_default
      val flag_false_default

    output:
      stdout
    
    script:
      def opt_optional = opt_optional ? "--min-length ${opt_optional}" : ""
      def opt_default = opt_default ?: '100'
      def flag_true_default = flag_true_default == false ? "" : "--trim-n"
      def flag_false_default = flag_false_default ? "--trim-n" : ""
      """
      echo --- SINGLES ---
      echo POSITIONAL: ${pos}
      echo OPTION: --min-length ${opt}
      echo OPTION_OPTIONAL: ${opt_optional}
      echo OPTION_DEFAULT: --min-length ${opt_default}
      echo FLAG_TRUE_DEFAULT: ${flag_true_default}
      echo FLAG_FALSE_DEFAULT: ${flag_false_default}
      """
}
