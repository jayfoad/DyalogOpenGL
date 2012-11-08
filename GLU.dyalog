:Namespace GLU

GLU_AUTO_LOAD_MATRIX←100200
GLU_BEGIN←100100
GLU_CCW←100121
GLU_CULLING←100201
GLU_CW←100120
GLU_DISPLAY_MODE←100204
GLU_DOMAIN_DISTANCE←100217
GLU_EDGE_FLAG←100104
GLU_END←100102
GLU_ERROR←100103
GLU_EXTENSIONS←100801
GLU_EXTERIOR←100123
GLU_FALSE←0
GLU_FILL←100012
GLU_FLAT←100001
GLU_INCOMPATIBLE_GL_VERSION←100903
GLU_INSIDE←100021
GLU_INTERIOR←100122
GLU_INVALID_ENUM←100900
GLU_INVALID_VALUE←100901
GLU_LINE←100011
GLU_MAP1_TRIM_2←100210
GLU_MAP1_TRIM_3←100211
GLU_NONE←100002
GLU_NURBS_ERROR10←100260
GLU_NURBS_ERROR11←100261
GLU_NURBS_ERROR12←100262
GLU_NURBS_ERROR13←100263
GLU_NURBS_ERROR14←100264
GLU_NURBS_ERROR15←100265
GLU_NURBS_ERROR16←100266
GLU_NURBS_ERROR17←100267
GLU_NURBS_ERROR18←100268
GLU_NURBS_ERROR19←100269
GLU_NURBS_ERROR1←100251
GLU_NURBS_ERROR20←100270
GLU_NURBS_ERROR21←100271
GLU_NURBS_ERROR22←100272
GLU_NURBS_ERROR23←100273
GLU_NURBS_ERROR24←100274
GLU_NURBS_ERROR25←100275
GLU_NURBS_ERROR26←100276
GLU_NURBS_ERROR27←100277
GLU_NURBS_ERROR28←100278
GLU_NURBS_ERROR29←100279
GLU_NURBS_ERROR2←100252
GLU_NURBS_ERROR30←100280
GLU_NURBS_ERROR31←100281
GLU_NURBS_ERROR32←100282
GLU_NURBS_ERROR33←100283
GLU_NURBS_ERROR34←100284
GLU_NURBS_ERROR35←100285
GLU_NURBS_ERROR36←100286
GLU_NURBS_ERROR37←100287
GLU_NURBS_ERROR3←100253
GLU_NURBS_ERROR4←100254
GLU_NURBS_ERROR5←100255
GLU_NURBS_ERROR6←100256
GLU_NURBS_ERROR7←100257
GLU_NURBS_ERROR8←100258
GLU_NURBS_ERROR9←100259
GLU_OUTLINE_PATCH←100241
GLU_OUTLINE_POLYGON←100240
GLU_OUTSIDE←100020
GLU_OUT_OF_MEMORY←100902
GLU_PARAMETRIC_ERROR←100216
GLU_PARAMETRIC_TOLERANCE←100202
GLU_PATH_LENGTH←100215
GLU_POINT←100010
GLU_SAMPLING_METHOD←100205
GLU_SAMPLING_TOLERANCE←100203
GLU_SILHOUETTE←100013
GLU_SMOOTH←100000
GLU_TESS_BEGIN_DATA←100106
GLU_TESS_BEGIN←100100
GLU_TESS_BOUNDARY_ONLY←100141
GLU_TESS_COMBINE_DATA←100111
GLU_TESS_COMBINE←100105
GLU_TESS_COORD_TOO_LARGE←100155
GLU_TESS_EDGE_FLAG_DATA←100110
GLU_TESS_EDGE_FLAG←100104
GLU_TESS_END_DATA←100108
GLU_TESS_END←100102
GLU_TESS_ERROR1←100151
GLU_TESS_ERROR2←100152
GLU_TESS_ERROR3←100153
GLU_TESS_ERROR4←100154
GLU_TESS_ERROR5←100155
GLU_TESS_ERROR6←100156
GLU_TESS_ERROR7←100157
GLU_TESS_ERROR8←100158
GLU_TESS_ERROR_DATA←100109
GLU_TESS_ERROR←100103
GLU_TESS_MAX_COORD←1E150
GLU_TESS_MISSING_BEGIN_CONTOUR←100152
GLU_TESS_MISSING_BEGIN_POLYGON←100151
GLU_TESS_MISSING_END_CONTOUR←100154
GLU_TESS_MISSING_END_POLYGON←100153
GLU_TESS_NEED_COMBINE_CALLBACK←100156
GLU_TESS_TOLERANCE←100142
GLU_TESS_VERTEX_DATA←100107
GLU_TESS_VERTEX←100101
GLU_TESS_WINDING_ABS_GEQ_TWO←100134
GLU_TESS_WINDING_NEGATIVE←100133
GLU_TESS_WINDING_NONZERO←100131
GLU_TESS_WINDING_ODD←100130
GLU_TESS_WINDING_POSITIVE←100132
GLU_TESS_WINDING_RULE←100140
GLU_TRUE←1
GLU_UNKNOWN←100124
GLU_U_STEP←100206
GLU_VERSION_1_1←1
GLU_VERSION_1_2←1
GLU_VERSION←100800
GLU_VERTEX←100101
GLU_V_STEP←100207

∇ r←getdllname
  :If 'Windows'≡7↑#.⎕WG'APLVersion'
      r←'glu32'
  :Else
      r←'libGLU.so'
  :Endif
∇

∇ {z}←gluBeginPolygon x
 :If 3≠⎕NC'gluBeginPolygon_DLL'
     'gluBeginPolygon_DLL'⎕NA getdllname,'|gluBeginPolygon I4'
 :EndIf
 z←gluBeginPolygon_DLL x
∇

∇ {z}←gluBeginSurface x
 :If 3≠⎕NC'gluBeginSurface_DLL'
     'gluBeginSurface_DLL'⎕NA getdllname,'|gluBeginSurface I4'
 :EndIf
 z←gluBeginSurface_DLL x
∇

∇ {z}←gluBeginTrim x
 :If 3≠⎕NC'gluBeginTrim_DLL'
     'gluBeginTrim_DLL'⎕NA getdllname,'|gluBeginTrim I4'
 :EndIf
 z←gluBeginTrim_DLL x
∇

∇ {z}←gluCylinder x
 :If 3≠⎕NC'gluCylinder_DLL'
     'gluCylinder_DLL'⎕NA getdllname,'|gluCylinder I4 F8 F8 F8 I4 I4'
 :EndIf
 z←gluCylinder_DLL x
∇

∇ {z}←gluDeleteNurbsRenderer x
 :If 3≠⎕NC'gluDeleteNurbsRenderer_DLL'
     'gluDeleteNurbsRenderer_DLL'⎕NA getdllname,'|gluDeleteNurbsRenderer I4'
 :EndIf
 z←gluDeleteNurbsRenderer_DLL x
∇

∇ {z}←gluDeleteQuadric x
 :If 3≠⎕NC'gluDeleteQuadric_DLL'
     'gluDeleteQuadric_DLL'⎕NA getdllname,'|gluDeleteQuadric I4'
 :EndIf
 z←gluDeleteQuadric_DLL x
∇

∇ {z}←gluDeleteTess x
 :If 3≠⎕NC'gluDeleteTess_DLL'
     'gluDeleteTess_DLL'⎕NA getdllname,'|gluDeleteTess I4'
 :EndIf
 z←gluDeleteTess_DLL x
∇

∇ {z}←gluDisk x
 :If 3≠⎕NC'gluDisk_DLL'
     'gluDisk_DLL'⎕NA getdllname,'|gluDisk I4 F8 F8 I4 I4'
 :EndIf
 z←gluDisk_DLL x
∇

∇ {z}←gluEndCurve x
 :If 3≠⎕NC'gluEndCurve_DLL'
     'gluEndCurve_DLL'⎕NA getdllname,'|gluEndCurve I4'
 :EndIf
 z←gluEndCurve_DLL x
∇

∇ {z}←gluEndPolygon x
 :If 3≠⎕NC'gluEndPolygon_DLL'
     'gluEndPolygon_DLL'⎕NA getdllname,'|gluEndPolygon I4'
 :EndIf
 z←gluEndPolygon_DLL x
∇

∇ {z}←gluEndSurface x
 :If 3≠⎕NC'gluEndSurface_DLL'
     'gluEndSurface_DLL'⎕NA getdllname,'|gluEndSurface I4'
 :EndIf
 z←gluEndSurface_DLL x
∇

∇ {z}←gluEndTrim x
 :If 3≠⎕NC'gluEndTrim_DLL'
     'gluEndTrim_DLL'⎕NA getdllname,'|gluEndTrim I4'
 :EndIf
 z←gluEndTrim_DLL x
∇

∇ {z}←gluGetNurbsProperty x
 :If 3≠⎕NC'gluGetNurbsProperty_DLL'
     'gluGetNurbsProperty_DLL'⎕NA'I4 ',getdllname,'|GetNurbsProperty I4 U4 =F4[]'
 :EndIf
 z←gluGetNurbsProperty_DLL x
∇

∇ {z}←gluLoadSamplingMatrices x
 :If 3≠⎕NC'gluLoadSamplingMatrices_DLL'
     'gluLoadSamplingMatrices_DLL'⎕NA getdllname,'|gluLoadSamplingMatrices I4 <F4[16] <F4[16] <I4[4]'
 :EndIf
 z←gluLoadSamplingMatrices_DLL x
∇

∇ {z}←gluLookAt x
 :If 3≠⎕NC'gluLookAt_DLL'
     'gluLookAt_DLL'⎕NA getdllname,'|gluLookAt F8 F8 F8 F8 F8 F8 F8 F8 F8'
 :EndIf
 z←gluLookAt_DLL x
∇

∇ z←gluNewNurbsRenderer
 :If 3≠⎕NC'gluNewNurbsRenderer_DLL'
     'gluNewNurbsRenderer_DLL'⎕NA'I4 ',getdllname,'|gluNewNurbsRenderer'
 :EndIf
 z←gluNewNurbsRenderer_DLL
∇

∇ {z}←gluNewQuadric
 :If 3≠⎕NC'gluNewQuadric_DLL'
     'gluNewQuadric_DLL'⎕NA'I4 ',getdllname,'|gluNewQuadric'
 :EndIf
 z←gluNewQuadric_DLL
∇

∇ z←gluNewTess
 :If 3≠⎕NC'gluNewTess_DLL'
     'gluNewTess_DLL'⎕NA'I4 ',getdllname,'|gluNewTess'
 :EndIf
 z←gluNewTess_DLL
∇

∇ z←gluNextContour x
 :If 3≠⎕NC'gluNextContour_DLL'
     'gluNextContour_DLL'⎕NA getdllname,'|gluNextContour I4 U4'
 :EndIf
 z←gluNextContour_DLL
∇

∇ {z}←gluNurbsCallback x
 :If 3≠⎕NC'gluNurbsCallback_DLL'
     'gluNurbsCallback_DLL'⎕NA getdllname,'|gluNurbsCallback I4 U4'
 :EndIf
 z←gluNurbsCallback_DLL x
∇

∇ {z}←gluNurbsCurve x
 :If 3≠⎕NC'gluNurbsCurve_DLL'
     'gluNurbsCurve_DLL'⎕NA getdllname,'|gluNurbsCurve I4 I4 =F4[] I4 =F4[] I4 U4'
 :EndIf
 z←gluNurbsCurve_DLL x
∇

∇ {z}←gluNurbsProperty x
 :If 3≠⎕NC'gluNurbsProperty_DLL'
     'gluNurbsProperty_DLL'⎕NA getdllname,'|gluNurbsProperty I4 U4 F4'
 :EndIf
 z←gluNurbsProperty_DLL x
∇

∇ {z}←gluNurbsSurface x
 :If 3≠⎕NC'gluNurbsSurface_DLL'
     'gluNurbsSurface_DLL'⎕NA getdllname,'|gluNurbsSurface I4 I4 =F4[] I4 =F4[] I4 I4 =F4[] I4 I4 U4'
 :EndIf
 z←gluNurbsSurface_DLL x
∇

∇ {z}←gluOrtho2D x
 :If 3≠⎕NC'gluOrtho2D_DLL'
     'gluOrtho2D_DLL'⎕NA'U4 ',getdllname,'|gluOrtho2D F8 F8 F8 F8'
 :EndIf
 z←gluOrtho2D_DLL x
∇

∇ {z}←gluPartialDisk x
 :If 3≠⎕NC'gluPartialDisk_DLL'
     'gluPartialDisk_DLL'⎕NA getdllname,'|gluPartialDisk I4 F8 F8 I4 I4 F8 F8'
 :EndIf
 z←gluPartialDisk_DLL x
∇

∇ {z}←gluPerspective x
 :If 3≠⎕NC'gluPerspective_DLL'
     'gluPerspective_DLL'⎕NA'U4 ',getdllname,'|gluPerspective F8 F8 F8 F8'
 :EndIf
 z←gluPerspective_DLL x
∇

∇ {z}←gluPickMatrix x
 :If 3≠⎕NC'gluPickMatrix_DLL'
     'gluPickMatrix_DLL'⎕NA'opengl32|gluPickMatrix F8 F8 F8 F8 <I4[4]'
 :EndIf
 z←gluPickMatrix_DLL x
∇

∇ {z}←gluPwlCurve x
 :If 3≠⎕NC'gluPwlCurve_DLL'
     'gluPwlCurve_DLL'⎕NA getdllname,'|gluPwlCurve I4 I4 =F4[] I4 U4'
 :EndIf
 z←gluPwlCurve_DLL x
∇

∇ {z}←gluQuadricCallback x
 :If 3≠⎕NC'gluQuadricCallback_DLL'
     'gluQuadricCallback_DLL'⎕NA getdllname,'|gluQuadricCallback I4 U4 <0T'
 :EndIf
 z←gluQuadricCallback_DLL x
∇

∇ {z}←gluQuadricDrawStyle x
 :If 3≠⎕NC'gluQuadricDrawStyle_DLL'
     'gluQuadricDrawStyle_DLL'⎕NA getdllname,'|gluQuadricDrawStyle I4 U4'
 :EndIf
 z←gluQuadricDrawStyle_DLL x
∇

∇ {z}←gluQuadricNormals x
 :If 3≠⎕NC'gluQuadricNormals_DLL'
     'gluQuadricNormals_DLL'⎕NA getdllname,'|gluQuadricNormals I4 U4'
 :EndIf
 z←gluQuadricNormals_DLL x
∇

∇ {z}←gluQuadricOrientation x
 :If 3≠⎕NC'gluQuadricOrientation_DLL'
     'gluQuadricOrientation_DLL'⎕NA getdllname,'|gluQuadricOrientation I4 U4'
 :EndIf
 z←gluQuadricOrientation_DLL x
∇

∇ {z}←gluQuadricTexture x
 :If 3≠⎕NC'gluQuadricTexture_DLL'
     'gluQuadricTexture_DLL'⎕NA getdllname,'|gluQuadricTexture I4 U1'
 :EndIf
 z←gluQuadricTexture_DLL x
∇

∇ {z}←gluSphere x
 :If 3≠⎕NC'gluSphere_DLL'
     'gluSphere_DLL'⎕NA getdllname,'|gluSphere I4 F8 I4 I4'
 :EndIf
 z←gluSphere_DLL x
∇

∇ {z}←gluTessVertex x
 :If 3≠⎕NC'gluTessVertex_DLL'
     'gluTessVertex_DLL'⎕NA getdllname,'|gluTessVertex I4 =F8[3] =F4[]'
 :EndIf
 z←gluTessVertex_DLL x
∇

:EndNamespace
