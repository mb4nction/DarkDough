// d3.js bubbles implementation.
// Technologies: HTML, CSS, JavaScript, SVG, d3.js

// 2012-03-16
// Step 1. Lines (no-animated)

(function($) {
  $.fn.implementSvg = function() {
    var init = function() {
      var $this = $(this),
          $containersForDrawing = $('div[class*=container].svg');

      var container = $('.spending_container');
      var data = container.find('.data').text().split(',');
      var sum = parseFloat($('.data-sum').text());
      for (i in data) {
        data[i] = Math.round((parseFloat(data[i]) / sum) * 1000) / 10;
      };

      var chart = d3.select(".spending_container.bubble-info")
                    .append("svg")
                    .attr("class", "chart")
                    .attr("width", 600)
                    .attr("height", 200);
      var x = d3.scale.linear()
                .domain([0, d3.max(data)])
                .range([40, 600]);

      chart.selectAll("rect").data(data).enter()
                             .append("rect")
                             .attr("y", function(d, i) { return i * 25; })
                             .attr("width", x)
                             .attr("height", 25);

      var y = d3.scale.ordinal().domain(data).rangeBands([0, 125]);

      chart.selectAll("text").data(data).enter().append("text")
                             .attr("x", x)
                             .attr("y", function(d) {return y(d) + y.rangeBand() / 2})
                             .attr("dx", -3)
                             .attr("dy", ".35em")
                             .attr("text-anchor", "end")
                             .text(String);
    };




    return init.call(this);

    // return this.each(function() {
    //   init.call(this);
    // });
  }
})(jQuery)