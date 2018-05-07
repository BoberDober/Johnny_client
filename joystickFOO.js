function getCountSteps() {
    var m_count = 0
    var m_min = minValue
    var m_max = maxValue
    if(minValue < 0)
        m_min = -1 * m_min
    if(maxValue < 0)
        m_max = -1 * m_max
    m_count = m_min + m_max
    return m_count
}

function getWeight() {
    var m_weight = 0;

    switch(typeStick)
    {
    case 1: m_weight = height / countSteps
        break;
    case 2: m_weight = width / countSteps
        break;
    case 3: m_weight = height / countSteps
        break;
    default: m_weight = height / countSteps
        break;
    }
//    console.log("WEIGHT " + m_weight + " " + typeStick)
    return m_weight
}

function setVisible() {
    var m_visible = false;
    switch(typeStick)
    {
    case 0: m_visible = false;
        break;
    default: m_visible = true;
        break;
    }
    return m_visible;
}

function getWidth() {
    var m_width = 0;
//    console.log("getWidth width " + width + " height " + height + " size " + size)
    switch(typeStick)
    {
    case 1: m_width = 30
        break;
    case 2: m_width = size
        break;
    case 3: m_width = size
        break;
    default: m_width = 0;
//             console.log("getWidth()" + type_stick)
        break;
    }
    return m_width;
}

function getHeight() {
    var m_height = 0;
//    console.log("getHeight width " + width + " height " + height + " size " + size)
    switch(typeStick)
    {
    case 1: m_height = 100
        break;
    case 2: m_height = size / 5
        break;
    case 3: m_height = size
        break;
    default: m_height = 0; //console.log("getHeight()" + type_stick)
        break;
    }
    return m_height;
}

function getHandle() {
    var handleSize = 0;
    switch(typeStick)
    {
    case 1: handleSize = joystick.width * 1.2
        break;
    case 2: handleSize = joystick.height * 1.2
        break;
    case 3: handleSize = joystick.width / 3
        break;
    default: handleSize = 0
        break;
    }
    return handleSize;
}

function getPointBeginX() {
    var m_pointBeginX = 0;
    switch(typeStick)
    {
    case 1: m_pointBeginX = width / 2
        break;
    case 2: m_pointBeginX = Math.abs(minValue - pointBegin) * weight
        break;
    case 3: m_pointBeginX = width / 2
        break;
    default: m_pointBeginX = width / 2
        break;
    }
    return m_pointBeginX;
}

function getPointBeginY() {
    var m_pointBeginY = 0;
    switch(typeStick)
    {
    case 1: m_pointBeginY = Math.abs(pointBegin - maxValue) * weight
        break;
    case 2: m_pointBeginY = height / 2
        break;
    case 3: m_pointBeginY = height / 2
        break;
    default: m_pointBeginY = Math.abs(pointBegin - maxValue) * weight
        break;
    }
    return m_pointBeginY;
}

function getFingerOutOfBounds() {
    var m_fingerOutOfBounds = true
    var m_lenght

    switch(typeStick)
    {
        case 1:
            if(handleUp)
                m_lenght = borderBegin.y * borderBegin.y
            else
                m_lenght = (joystick.height - borderBegin.y) * (joystick.height - borderBegin.y)

            if((touch.x - startX) * (touch.x - startX) + (touch.y-startY) * (touch.y-startY) < m_lenght)
                m_fingerOutOfBounds = true
            else
                m_fingerOutOfBounds = false
            break;
        case 2:
            if(handleUp)
                m_lenght = (joystick.width -  borderBegin.x) * (joystick.width -  borderBegin.x)
            else
                m_lenght = borderBegin.x * borderBegin.x

            if((touch.x - startX) * (touch.x - startX) + (touch.y-startY) * (touch.y-startY) < m_lenght)
                m_fingerOutOfBounds = true
            else
                m_fingerOutOfBounds = false
            break;
        case 3:

            if((touch.x - startX) * (touch.x - startX) + (touch.y-startY) * (touch.y-startY) < (joystick.height / 2) * (joystick.height / 2 ))
                m_fingerOutOfBounds = true
            else
                m_fingerOutOfBounds = false

            break;
    }
    return m_fingerOutOfBounds
}
