/**
 * ibmaskeditinfo.js
 */

(function(global) {
    // Define Old Version Compatible Property
    var sPrefix = 'dt',
        tmpObj = {
            None    : 0,
            Date    : 1,
            Time    : 2,
            User    : 3,
            Number  : 4,
            Password: 5
        }, sName;

    for(sName in tmpObj) {
        global[sPrefix + sName] = tmpObj[sName];
    }

    /**
     * IBMaskEdit Initialize Method (Old Version Compatible)
     * Old   : createIBMaskEdit(id[, width, height, nType])
     * Latest: createIBMaskEdit(id, options)
     */
    global['createIBMaskEdit'] = function() {
        CreateIBMaskEdit(arguments);
    };
})(window);
