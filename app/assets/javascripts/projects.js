// variable to store total_time
est_total_time = 0.0;

$(document).ready(function() {
    $("#owner a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#owner').bind('cocoon:after-insert',
         function() {
           $("#owner_from_list").hide();
           $("#owner a.add_fields").hide();
         });
    $('#owner').bind("cocoon:after-remove",
         function() {
           $("#owner_from_list").show();
           $("#owner a.add_fields").show();
         });

    $("#tags a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#tags').bind('cocoon:after-insert',
         function(e, tag) {
             console.log('inserting new tag ...');
             $(".task-tag-fields a.add-tag").
                 data("association-insertion-position", 'after').
                 data("association-insertion-node", 'this');
             $(this).find('.task-tag-fields').bind('cocoon:after-insert',
                  function() {
                    console.log('insert new tag ...');
                    console.log($(this));
                    $(this).find(".tag_from_list").remove();
                    $(this).find("a.add_fields").hide();
                  });
         });

    $('.task-tag-fields').bind('cocoon:after-insert',
        function(e) {
            console.log('replace OLD tag ...');
            e.stopPropagation();
            console.log($(this));
            $(this).find(".tag_from_list").remove();
            $(this).find("a.add_fields").hide();
        });


    $('#tasks').bind('cocoon:before-insert', function(e,task_to_be_added) {
        console.log(task_to_be_added);
        task_to_be_added.fadeIn('slow');
    });

    $('#tasks').bind('cocoon:after-insert', function(e, added_task) {
        //added_task.css("background","red");

    });

    $('#tasks').bind('cocoon:before-remove', function(e, task) {
        $(this).data('remove-timeout', 1000);
        task.fadeOut('slow');
    });

    //$('body').tabs();

    // function to display est_time
    // function will be called whenever there is a change for any class 'complexity_list' within body
    $('body').on('change', ".complexity_list", function() {
        // identify the current instance of task being filled in
        var task_id = $(this).children().children().attr('id');
        // pass the tag name
        var tag_id = $(this).parent().parent().find('.tag_from_list option:selected');
        console.log(tag_id);
        $.ajax({
            url: "/newprojects/show_est_time",
            data: {
                tag_id: tag_id.text(),
                complexity_id: $(this).find('option:selected').text(),
                task_id: task_id
            },
            dataType: "script",
            // success: function(data) {
            //   callback(data);
            //   // $.each(time_text.info, function(){
            //   //   var est_time = this.est_time;
            //   //   console.log(time_text);
            //   //   callback(time_text);
            //   // });
            // },
            error: function(req, status, err) {
              console.log('something went wrong', status, err);
            }
        })
        .done(function(data) {
          console.log('from done function: ' + time_text);
          time_text = parseFloat(time_text);
          est_total_time = totalTime(time_text);
          console.log('est_total_time returned: ' + est_total_time);
          // passing est_total_time value to project#new
          $('.est-total-time').html("Total time estimated: " + est_total_time);
        });
    });

    // get total project time
    function totalTime(data) {
      console.log('time_text from done function: ' + time_text);
      console.log('time_text type: ' + typeof time_text);
      console.log('total_time type: ' + typeof est_total_time);
      est_total_time = est_total_time + time_text;
      console.log('est_total_time calculated: ' + est_total_time);
      return est_total_time;
    };

    // function to hide or show add tag link

    $('body').on('change', ".nested-fields.task-tag-fields", function() {
      // limits the number of categories
      $('.btn.btn-default.add-tag-btn.add_fields').bind('cocoon:after-insert', function() {
        check_to_hide_or_show_add_link();
      });

      $('.btn.btn-default.add-tag-btn.add_fields').bind('cocoon:after-remove', function() {
        check_to_hide_or_show_add_link();
      });

      check_to_hide_or_show_add_link();
    });

    function check_to_hide_or_show_add_link() {
      $('.nested-fields.well.well-compact').each(
        function() {
          if ($('.nested-fields.task-tag-fields').length >= 1) {
            $('.btn.btn-default.add-tag-btn.add_fields').hide();
            // $('.btn.btn-default.add-tag-btn.add_fields').css("background","green");
          } else {
            $('.btn.btn-default.add-tag-btn.add_fields').show();
            // $('.btn.btn-default.add-tag-btn.add_fields').css("background","red");
          }
        }
      );
    };

    // iterating through each dynamic association generated when adding a task
    // $(document).on("change", "input[class^=tag_from_list], input[class^=complexity]", function() {
    //     $("input[class^=complexity]").trigger("change");
    // });

    // $(document).on("change", "input[class^=complexity]", function() {
    //   var complexity = $("option:selected", this).closest("div").siblings().find("input[class^=complexity]");
    //   var tag = $("option:selected", this).closest("div").siblings().find("input[class^=tag_from_list]");
    //   // call to AJAX to do model calculations for est_time
    //   $.ajax({
    //     url: "/newprojects/show_est_time",
    //     data: {
    //       tag_id: tag.text(),
    //       complexity_id: complexity.text()
    //     }
    //     dataType: "script"
    //   });
    // });

});