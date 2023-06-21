<!DOCTYPE html>
<html lang="en">
<head>
<title>The Print Farm</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
* {
  box-sizing: border-box;
}

body {
    background-color: #919191;
    margin: 0;
}

/* Style the header */
.header {
    background-color: #414141;
    padding: 2px;
    text-align: center;
}

/* Create three unequal columns that floats next to each other */
.column {
  float: right;
  padding: 5px;
}

/* Left and right column */
.column-side {
    padding: 5px
  width: 15%;
}

/* Middle column */
.column.middle {
    width: 85%;
    padding: 10px;
}

/* Clear floats after the columns */
.row::after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - makes the three columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .column.side, .column.middle {
    width: 100%;
  }
}
</style>
<script type="application/javascript">
  var optDivs = [
  %for k in data.keys():
      %if not callable(data[k]) and k != 'GoSlice':
      "{{ k }}",
      %end
  %end
  ];

  function toggleDivVisibility(showThis) {
      for (var i = 0; i < optDivs.length; i++) {
          var div = document.getElementById('opts-' + optDivs[i]);
          if (optDivs[i] === showThis) {
              div.style.display = 'block';
          } else {
              div.style.display = 'none';
          }
      }
  }

</script>
</head>
<body>

<div class="header">
  <h1>Prepare STL for slicing.</h1>
</div>

<div class="row">
  <div class="column-side w3-sidebar w3-dark-grey w3-bar-block" style="width:15%">
    <h3 class="w3-bar-item">Menu</h3>
    %for k in data.keys():
    %if not callable(data[k]) and k != 'GoSlice':
    <a href="#" class="w3-bar-item w3-button" onclick="toggleDivVisibility('{{ k }}')">{{ k }}</a>
    %end
    %end
  </div>

  <div class="column middle" style="padding: 10px;">
    <form action="http://{{ endpoint }}/stl/{{ engine }}" enctype="multipart/form-data" method="post">
      <input type="file" name="file" id="file">
      %for ka, va in data.items():
      %if not callable(va) and ka != 'GoSlice':
      <!-- start of {{ ka }}'s content -->
      <div id="opts-{{ ka }}" style="display: none; padding: 20px;">
        <h2>{{ ka }}</h2>
        %for kb, vb in data['json2form'](va).items():
        %if vb['type'] != 'fieldset':
        <label for=".{{ ka }}.{{ kb }}">{{ kb }}</label>
        <input type="{{ vb['type'] }}" id=".{{ ka }}.{{ kb }}" name=".{{ ka }}.{{ kb }}" value="{{ vb['value'] }}" /><br />
        %else:
        <fieldset style="width: 50%;">
          <legend>{{ kb }}</legend>
          %for kc, vc in vb['value'].items():
          <label for=".{{ ka }}.{{ kb }}.{{ kc }}">{{ kc }}</label>
          <input type="{{ vc['type'] }}" id=".{{ ka }}.{{ kb }}.{{ kc }}" name=".{{ ka }}.{{ kb }}.{{ kc }}" value="{{ vc['value'] }}" /><br />
          %end
          <!-- endfor -->
        </fieldset>
        %end
        <!-- endif -->
        %end
        <!-- endfor -->
      </div>
      <!-- End of {{ ka }}'s content -->
      %end
      %end
      <input type="submit" value="Upload" name="submit">
    </form>
  </div>
</div>

</body>
<script type="application/javascript">
  toggleDivVisibility(optDivs[0]);
</script>
</html>
