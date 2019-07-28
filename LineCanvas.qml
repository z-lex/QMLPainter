import QtQuick 2.0

Item {
    property var lines: []
    property string curcolor: "#00ff00"
    property real curwidth: 5

    Canvas {
        id: lineCanvas
        anchors.fill: parent

        Component.onCompleted: {
            /* Здесь невозможно получить контекст,
            требуется дождаться available: true */
            //ctx = lineCanvas.getContext("2d");
        }

        onPaint: {
            lineCanvas.getContext("2d");
            redrawLines();
        }

    }

    MouseArea {
        id: canvasMouseArea
        anchors.fill: parent
        property var pts: []
        onPressed: {
            pts.push({ "x": mouseX, "y": mouseY });
            addLine(parent.curcolor, parent.curwidth, pts);
        }
        onPositionChanged: {
            // удаление последней линии
            lines.pop();

            // добавление дополненной линии
            pts.push({ "x": mouseX, "y": mouseY });
            addLine(parent.curcolor, parent.curwidth, pts);
        }
        onReleased: {
            pts = [];
        }
    }

    function incrWidth() {
        if (curwidth <= 40) curwidth += 1;
    }

    function decrWidth() {
        if (curwidth > 1) curwidth -= 1;
    }

    // отрисовать линию из списка под указанным индексом
    function drawLineAtIndex(iLine) {

        if (iLine >= lines.length) return;

        var line = lines[iLine];
        if (line.points.length === 0) return;

        var ctx = lineCanvas.context;

        ctx.strokeStyle = line.color;
        ctx.lineWidth = line.width;
        ctx.beginPath();
        var pt = line.points[0];
        ctx.moveTo(pt.x, pt.y);
        for (var iPoint = 1; iPoint < line.points.length; iPoint++) {
            pt = line.points[iPoint];
            ctx.lineTo(pt.x, pt.y);
        }
        ctx.stroke();
    }

    // добавить линию в список и отрисовать
    function addLine(color, width, points) {
        if (points.length === 0) return;
        lines.push({
           "color": color,
           "width": width,
           "points": points });

        drawLineAtIndex(lines.length-1);
        lineCanvas.requestPaint();
    }

    // функция перерисовки линий
    function redrawLines() {
        lineCanvas.context.clearRect(0, 0,
                                     lineCanvas.width,
                                     lineCanvas.height);

        for (var iLine = 0; iLine < lines.length; iLine++) {
            drawLineAtIndex(iLine);
        }

    }

    // удалить из списка линии указанного цвета
    // и выполнить перерисовку
    function removeColor(color) {

        /* Удаляем из списка линии указанного цвета */
        lines = lines.filter(function (line) {
            return line.color !== color;
        })

        redrawLines();
        lineCanvas.requestPaint();
    }
}
