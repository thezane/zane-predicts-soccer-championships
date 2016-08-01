classdef RatingsOutput
  properties
    strCost
    strMedianCost
    strAll
    strMedian
    mTree
    mi
    tTree
    n
    i
  end
  
  methods
    function rOutput = RatingsOutput(tTree, mTree, mi, numMatches)
      rOutput.tTree = tTree;
      rOutput.mTree = mTree;
      rOutput.mi = mi;
      rOutput.strCost = 0;
      rOutput.n = 2 * numMatches;
      rOutput.strAll = zeros(numMatches, 2);
      rOutput.i = 1;
    end
    
    function rOutput = updateStrAll(rOutput, str)
      if (rOutput.i + 1 <= rOutput.n)
        rOutput.strAll(rOutput.i: rOutput.i + 1, :) = str;
        rOutput.i = rOutput.i + 2;
      end
    end
    
    function [rOutput strMedianCost] = updateStrMedianCost(rOutput)
      rOutput.strMedian = median(rOutput.strAll);
      strMedian = rOutput.strMedian;
      rOutput.strMedianCost = ...
          computeMSE(computeStrNorm(strMedian(1)), 0) + ...
          computeMSE(computeStrNorm(strMedian(2)), 0);
      strMedianCost = rOutput.strMedianCost;
    end
  end
end
