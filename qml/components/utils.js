function interpolate(str, o) {
    try {
        return str.replace(/{([^{}]*)}/g,
            function (a, b) {
                var r = o[b];
                    return typeof r === 'string' || typeof r === 'number' ? r : a;
            }
        );
    } catch(e) {
        console.log('Oops')
    }
};
