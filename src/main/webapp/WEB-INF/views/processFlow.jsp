<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:html>
    <t:head imageList="true" processHandler="true">
        <title>OCR4All - Centralized Process Flow</title>

        <script type="text/javascript">
            $(document).ready(function() {
                // Load image list
                initializeImageList("Original");

                $('.collapsible').collapsible('open', 0);

                function getProcessesToExecute() {
                    var processesToExecute = [];
                    $.each($('#processSelection input[type="checkbox"]'), function() {
                        if( $(this).is(':checked') )
                            processesToExecute.push($(this).attr('data-id'));
                    });
                    return processesToExecute;
                }

                // Start processflow execution
                //TODO: Track status of different processes somehow
                //TODO: Error handling
                $('button[data-id="execute"]').click(function() {
                    var selectedPages = getSelectedPages();
                    if( selectedPages.length === 0 ) {
                        $('#modal_errorhandling').modal('open');
                        return;
                    }

                    var processesToExecute = getProcessesToExecute();

                    var ajaxParams = { "pageIds[]" : selectedPages, "processesToExecute[]" : processesToExecute };
                    $.post( "ajax/processflow/execute", ajaxParams );
                });
            });
        </script>
    </t:head>
    <t:body heading="Centralized Process Flow" imageList="true" processModals="true">
        <div class="container includes-list">
            <div class="section">
                <button data-id="execute" class="btn waves-effect waves-light">
                    Execute
                    <i class="material-icons right">chevron_right</i>
                </button>
                <button data-id="cancel" class="btn waves-effect waves-light">
                    Cancel
                    <i class="material-icons right">cancel</i>
                </button>

                <ul class="collapsible" data-collapsible="expandable">
                    <li>
                        <div class="collapsible-header"><i class="material-icons">format_indent_increase</i>Process selection</div>
                        <div class="collapsible-body">
                            <table id="processSelection" class="compact clinched">
                                <tbody>
                                    <tr>
                                        <td><p>Preprocessing</p></td>
                                        <td>
                                            <p>
                                                <input type="checkbox" class="filled-in" id="runPreprocessingProcess" data-id="preprocessing" checked="checked" />
                                                <label for="runPreprocessingProcess"></label>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><p>Noise Removal</p></td>
                                        <td>
                                            <p>
                                                <input type="checkbox" class="filled-in" id="runDespecklingProcess" data-id="despeckling" checked="checked" />
                                                <label for="runDespecklingProcess"></label>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><p>Segmentation</p></td>
                                        <td>
                                            <p>
                                                <input type="checkbox" class="filled-in" id="runSegmentationProcess" data-id="segmentation" checked="checked" />
                                                <label for="runSegmentationProcess"></label>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><p>Region Extraction</p></td>
                                        <td>
                                            <p>
                                                <input type="checkbox" class="filled-in" id="runRegionExtractionProcess" data-id="regionextraction" checked="checked" />
                                                <label for="runRegionExtractionProcess"></label>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><p>Line Segmentation</p></td>
                                        <td>
                                            <p>
                                                <input type="checkbox" class="filled-in" id="runLineSegmentationProcess" data-id="linesegmentation" checked="checked" />
                                                <label for="runLineSegmentationProcess"></label>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><p>Recognition</p></td>
                                        <td>
                                            <p>
                                                <input type="checkbox" class="filled-in" id="runRecognitionProcess" data-id="recognition" checked="checked" />
                                                <label for="runRecognitionProcess"></label>
                                            </p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </li>
                    <li>
                        <div class="collapsible-header"><i class="material-icons">info_outline</i>Status (Preprocessing)</div>
                        <div class="collapsible-body">
                            <div class="status"><p>Status: <span>No Preprocessing process running</span></p></div>
                            <div class="progress">
                                <div class="determinate"></div>
                            </div>
                            <div class="console">
                                 <ul class="tabs">
                                     <li class="tab" data-refid="consoleOutPreprocessing" class="active"><a href="#consoleOutPreprocessing">Console Output</a></li>
                                     <li class="tab" data-refid="consoleErrPreprocessing"><a href="#consoleErrPreprocessing">Console Error</a></li>
                                 </ul>
                                <div id="consoleOutPreprocessing"><pre></pre></div>
                                <div id="consoleErrPreprocessing"><pre></pre></div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="collapsible-header"><i class="material-icons">info_outline</i>Status (Noise Removal)</div>
                        <div class="collapsible-body">
                            <div class="status"><p>Status: <span>No Noise Removal process running</span></p></div>
                            <div class="progress">
                                <div class="determinate"></div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="collapsible-header"><i class="material-icons">info_outline</i>Status (Segmentation)</div>
                        <div class="collapsible-body">
                            <div class="status"><p>Status: <span>No Segmentation process running</span></p></div>
                            <div class="progress">
                                <div class="determinate"></div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="collapsible-header"><i class="material-icons">info_outline</i>Status (Region Extraction)</div>
                        <div class="collapsible-body">
                            <div class="status"><p>Status: <span>No Region Extraction process running</span></p></div>
                            <div class="progress">
                                <div class="determinate"></div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="collapsible-header"><i class="material-icons">info_outline</i>Status (Line Segmentation)</div>
                        <div class="collapsible-body">
                            <div class="status"><p>Status: <span>No Line Segmentation process running</span></p></div>
                            <div class="progress">
                                <div class="determinate"></div>
                            </div>
                            <div class="console">
                                 <ul class="tabs">
                                     <li class="tab" data-refid="consoleOutLineSegmentation" class="active"><a href="#consoleOutLineSegmentation">Console Output</a></li>
                                     <li class="tab" data-refid="consoleErrLineSegmentation"><a href="#consoleErrLineSegmentation">Console Error</a></li>
                                 </ul>
                                <div id="consoleOutLineSegmentation"><pre></pre></div>
                                <div id="consoleErrLineSegmentation"><pre></pre></div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="collapsible-header"><i class="material-icons">info_outline</i>Status (Recognition)</div>
                        <div class="collapsible-body">
                            <div class="status"><p>Status: <span>No Recognition process running</span></p></div>
                            <div class="progress">
                                <div class="determinate"></div>
                            </div>
                            <div class="console">
                                 <ul class="tabs">
                                     <li class="tab" data-refid="consoleOutRecognition" class="active"><a href="#consoleOutRecognition">Console Output</a></li>
                                     <li class="tab" data-refid="consoleErrRecognition"><a href="#consoleErrRecognition">Console Error</a></li>
                                 </ul>
                                <div id="consoleOutRecognition"><pre></pre></div>
                                <div id="consoleErrRecognition"><pre></pre></div>
                            </div>
                        </div>
                    </li>
                </ul>

                <button data-id="execute" class="btn waves-effect waves-light">
                    Execute
                    <i class="material-icons right">chevron_right</i>
                </button>
                <button data-id="cancel" class="btn waves-effect waves-light">
                    Cancel
                    <i class="material-icons right">cancel</i>
                </button>
            </div>
        </div>
    </t:body>
</t:html>