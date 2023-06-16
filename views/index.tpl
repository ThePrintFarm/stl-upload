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
  float: left;
  padding: 5px;
}

/* Left and right column */
.column.side {
  width: 25%;
}

/* Middle column */
.column.middle {
    width: 75%;
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
      "{{ k }}",
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
  <div class="column side">
    <div class="w3-sidebar w3-dark-grey w3-bar-block" style="width:25%">
      <h3 class="w3-bar-item">Menu</h3>
      %for k in data.keys():
      <a href="#" class="w3-bar-item w3-button" onclick="toggleDivVisibility('{{ k }}')">{{ k }}</a>
      %end
    </div>
  </div>

  <div class="column middle" style="padding: 10px;">
    <form action="http://localhost:9999/stl" enctype="multipart/form-data" method="post">
      <input type="file" name="file" id="file">
      %for ka, va in data.items():
      <div id="opts-{{ ka }}" style="display: none; padding: 20px;">
        <h2>{{ ka }}</h2>
        {{ va }}
      </div>
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
