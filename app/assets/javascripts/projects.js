function getTime() {
  $('.complexity_list').change(function() {
    var task_id = $(this).children().children().attr('id');
    var tag_id = $(this).parent().parent().find('.tag_from_list option:selected');
    console.log(tag_id);
    $.ajax({
        url: "/newprojects/show_est_time",
        data: {
            tag_id: tag_id.text(),
            complexity_id: $(this).find('option:selected').text(),
            task_id: task_id
        },
        dataType: "script"
    })
    .done(function(data) {
      console.log(data);
    })
  });
}

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
        getTime();
    });

    $('#tasks').bind('cocoon:after-insert', function(e, added_task) {
        //added_task.css("background","red");
    });

    $('#tasks').bind('cocoon:before-remove', function(e, task) {
        $(this).data('remove-timeout', 1000);
        task.fadeOut('slow');
    });

    getTime();

    //$('body').tabs();

    // function to hide or show add tag link

    // $(function() {
    //     function check_to_hide_or_show_add_link() {
    //         if ($('#tags .nested-fields.task-tag-fields').length == 1) {
    //             $('#tags .links a').hide();
    //         } else {
    //             $('#tags .links a').show();
    //         }
    //     }

    //     $('#tags').bind('cocoon:after-insert', function() {
    //         check_to_hide_or_show_add_link();
    //     });

    //     $('#tags').bind('cocoon:after-remove', function() {
    //         check_to_hide_or_show_add_link();
    //     });

    //     check_to_hide_or_show_add_link();     
    // });

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

    // working est_time display



});