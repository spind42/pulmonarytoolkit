classdef PTKSegmentalBronchi < PTKPlugin
    % PTKSegmentalBronchi. Plugin to find the segmental bronchi in each lobe
    %
    %     This is a plugin for the Pulmonary Toolkit. Plugins can be run using 
    %     the gui, or through the interfaces provided by the Pulmonary Toolkit.
    %     See PTKPlugin.m for more information on how to run plugins.
    %
    %     Plugins should not be run directly from your code.
    %
    %
    %     Licence
    %     -------
    %     Part of the TD Pulmonary Toolkit. http://code.google.com/p/pulmonarytoolkit
    %     Author: Tom Doel, 2013.  www.tomdoel.com
    %     Distributed under the GNU GPL v3 licence. Please see website for details.
    %    
 
    properties
        ButtonText = 'Segmental<br>bronchi'
        ToolTip = 'Finds the segmental bronchi in each lobe'
        Category = 'Airways'
 
        AllowResultsToBeCached = true
        AlwaysRunPlugin = false
        PluginType = 'DoNothing'
        HidePluginInDisplay = true
        FlattenPreviewImage = true
        PTKVersion = '1'
        ButtonWidth = 6
        ButtonHeight = 2
        GeneratePreview = false
        Visibility = 'Developer'
end
    
    methods (Static)
        function results = RunPlugin(dataset, reporting)
            lobes = dataset.GetResult('PTKLobes');
            centreline_tree = dataset.GetResult('PTKAirwayCentreline');
            results_image = dataset.GetTemplateImage(PTKContext.LungROI);
            centreline_tree.AirwayCentrelineTree.GenerateBranchParameters;
            new_centreline_tree = PTKGetSegmentalBronchiCentrelinesForEachLobe(centreline_tree.AirwayCentrelineTree, lobes, results_image, reporting);

            results = [];
            results.StartBranches = new_centreline_tree;
        end
    end 
end