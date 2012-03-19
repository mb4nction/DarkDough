// d3.js bubbles implementation.
// Technologies: HTML, CSS, JavaScript, SVG, d3.js

// 2012-03-16
// Step 1. Lines (no-animated)

(function($) {
  $.fn.implementSvg = function() {
    var init = function() {
      var $containersForDrawing = $('div[class*=container].svg');

      $containersForDrawing.each(function() {
        // get data
        var data = $(this).find('.data').text().split(','),
            elemCount = data.length;
            sum = parseFloat($(this).find('.data-sum').text());
        for (i in data) {
          data[i] = Math.round((parseFloat(data[i]) / sum) * 1000) / 10;
        };

        if (!isNaN(sum)) {
          var containerClass = $(this).attr('class').split(/\s+/)[0];
          var partialId = $(this).parent().attr('id');
          var chart = d3.select("#" + partialId + " ." + containerClass)
                        .append("svg")
                        .attr("class", "chart")
                        .attr("width", 500)
                        .attr("height", 200);
          var x = d3.scale.linear()
                    .domain([0, d3.max(data)])
                    .range([40, 500]);

          chart.selectAll("rect").data(data).enter()
                                 .append("rect")
                                 .attr("y", function(d, i) { return i * 25; })
                                 .attr("width", x)
                                 .attr("height", 25);

          var y = d3.scale.ordinal().domain(data).rangeBands([0, elemCount * 25]);

          chart.selectAll("text").data(data).enter()
                                 .append("text")
                                 .attr("x", x)
                                 .attr("y", function(d) {return y(d) + y.rangeBand() / 2})
                                 .attr("dx", -3)
                                 .attr("dy", ".35em")
                                 .attr("text-anchor", "end")
                                 .text(String);
        }
      });
    };

    return init.call(this);
  }
})(jQuery)