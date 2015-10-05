$(document).ready(function() {
  
  $("#owner a.add_fields").
    data("association-insertion-position", 'before').
    data("association-insertion-node", 'this');

  $('#owner').bind('cocoon:after-insert', function() {
    $("#owner_from_list").hide();
    $("#owner a.add_fields").hide();
  });
  
  $('#owner').bind("cocoon:after-remove", function() {
    $("#owner_from_list").show();
    $("#owner a.add_fields").show();
  });

  $("#tags a.add_fields").
    data("association-insertion-position", 'before').
    data("association-insertion-node", 'this');

  $('#tags').bind('cocoon:after-insert', function(e, tag) {
    console.log('inserting new tag ...');
    $(".task-tag-fields a.add-tag").
      data("association-insertion-position", 'after').
      data("association-insertion-node", 'this');
    $(this).find('.task-tag-fields').bind('cocoon:after-insert', function() {
      console.log('insert new tag ...');
      console.log($(this));
      $(this).find(".tag_from_list").remove();
      $(this).find("a.add_fields").hide();
    });
  });

  $('.task-tag-fields').bind('cocoon:after-insert', function(e) {
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
      error: function(req, status, err) {
        console.log('something went wrong', status, err);
      }
    })
    .done(function(data) {
      console.log("in the done fn")
      var totalEst = getTotalTime();
      console.log("total time returned: " + totalEst);
      $('.est-total-time').html("Total time: " + totalEst);
    });
  });

  // get total project time
  function getTotalTime() {
    var totalTime = 0;
    console.log("in the getTotalTime fn");
    $('.show_est_time').each(
      function(){
        console.log(jQuery(this).text());
        totalTime += parseFloat(jQuery(this).text());
      }
    );     
    return totalTime;
  }
  
  // hide add-tag button to prevent multiple categories per task
  $('.links.add-tag').find('a').hide();
  $('#tasks').on('click', '.remove-tag', function() {
    console.log('this is: ' + $(this).attr('class'));
    // $('.btn.btn-default.add-tag-btn.add_fields').show();
    add_tag = $(this).parent().parent().next().find('a');
    add_tag.show();
    console.log('this is: ' + $(add_tag).attr('class'));
  });

  $('#tasks').on('click', '.btn.btn-default.add-tag-btn.add_fields', function() {
    console.log('this is: ' + $(this).attr('class'));
    $(this).hide();
  });
  
});