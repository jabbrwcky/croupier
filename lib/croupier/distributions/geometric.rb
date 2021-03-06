module Croupier
  module Distributions

    #####################################################################
    # Geometric Distribution
    # Discrete probability distribution that expresses the number of X
    # Bernoulli trials needed to get one success, supported on the
    # set { 1, 2, 3, ...}
    #
    # Wikipedia -- http://en.wikipedia.org/wiki/Geometric_distribution
    # I made this choice because it's Knuth choice.
    # (The Art of Computer Programming, Volume 2, 3.4.1.F )
    class Geometric < ::Croupier::Distribution

      def initialize(options={})
        @name = "Geometric distribution"
        @description = "Discrete probability distribution that expresses the number of X Bernoulli trials needed to get one success, supported on the set { 1, 2, 3, ...}"
        configure(options)
        raise Croupier::InputParamsError, "Probability of success must be in the interval [0,1]" if params[:success] > 1 || params[:success] < 0
      end

      # Fair point: it is not the inverse of the cdf,
      # but it generates the distribution from an uniform.
      def inv_cdf n
        (Math.log(1-n) / Math.log(1-params[:success])).ceil
      end

      def default_parameters
        {:success => 0.5}
      end

      def self.cli_name
        "geometric"
      end

      def self.cli_options
        {:options => [
           [:success, 'success probability of each trial', {:type=>:float, :short => "-p", :default => 0.5}]
         ],
         :banner => "Geometric distribution. Discrete probability distribution that expresses the number of X Bernoulli trials needed to get one success, supported on the set { 1, 2, 3, ...} }"
        }
      end
    end
  end
end
